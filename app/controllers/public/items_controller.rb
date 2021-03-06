class Public::ItemsController < ApplicationController

  include ItemSearch
  before_action :set_parents

  def new
    @item = Item.new
    @item.shop_id = current_customer.shop.id
  end

  def create
    @item = Item.new(item_params)
    unless current_customer == @item.shop.customer
      redirect_to root_path
    else
      if @item.save
        redirect_to item_path(@item.id)
        flash[:notice] = "作品を登録しました。"
      else
        @item.shop_id = current_customer.shop.id
        render :new
      end
    end
  end

  def index
    @items = params[:is_active].present? ? Item.where(is_active: true) : Item.all
  end

  def show
    @item = Item.find(params[:id])
    @shop = Shop
    @category = Category
    @cart = Cart
    @cart_item = CartItem
    @review = Review.new
    @reviews = @item.reviews.all
    @blogs = Blog.limit(4).order(created_at: :desc).where(item_id: @item)
    @category_id = @item.category_id
    @category_parent = Category.find(@category_id).parent
    @category_child = Category.find(@category_id)
  end

  def edit
    @item = Item.find(params[:id])
    @category_id = @item.category_id
    @category_parent = Category.find(@category_id).parent
    @category_children = @category_parent.children
    unless current_customer.shop == @item.shop
      redirect_to root_path
    end
  end

  def update
    @item = Item.find(params[:id])
    unless current_customer == @item.shop.customer
      redirect_to root_path
    else
      if @item.update(item_params)
        flash[:notice] = "作品を編集しました。"
        redirect_to item_path(@item.id)
      else
        render :edit
      end
    end
  end

  def get_category_children
    @category_children = Category.find(params[:parent_id].to_s).children
  end

  def menu_search
    respond_to do |format|
      format.html
      format.json do
        if params[:parent_id]
          @childrens = Category.find(params[:parent_id].to_s).children
        elsif params[:children_id]
          @parents = Category.where(id: params[:children_id].to_s)
        end
      end
    end
  end

  def item_search
    @category = Category.find_by(id: params[:id])
    if @category.ancestry.nil?
      category = Category.find_by(id: params[:id]).child_ids
      if category.empty?
        @items = Item.where(category_id: @category.id).order(created_at: :desc)
      else
        @items = []
        find_item(category)
      end
    else
      @items = Item.where(category_id: params[:id]).order(created_at: :desc)
    end
    if params[:is_active].present?
      @true_items = @items.where(is_active: true)
    end
  end

  def find_item(category)
    category.each do |id|
      item_array = Item.where(category_id: id).order(created_at: :desc)
      next unless item_array.present?
      item_array.each do |item|
        @items.push(item) if item.present?
      end
    end
  end

  def item_blog
    @item = Item.find(params[:id])
    @blogs = Blog.where(item_id: @item)
  end

  private

  def item_params
    params.require(:item).permit(:shop_id, :name, :introduction, :size, :shipping_date, :price, :category_id, :is_active, :limit, item_images: [])
  end

end
