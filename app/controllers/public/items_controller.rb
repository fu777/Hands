class Public::ItemsController < ApplicationController

  before_action :set_parents

  def new
    @item = Item.new
    @item.shop_id = current_customer.shop.id
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to item_path(@item.id)
      flash[:notice] = "作品を登録しました。"
    else
      render :new
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
    @blogs = Blog.limit(5).order(created_at: :desc).where(item_id: @item)
  end

  def edit
    @item = Item.find(params[:id])
    unless current_customer.shop == @item.shop
      redirect_to root_path
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "作品を編集しました。"
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def get_category_children
    @category_children = Category.find(params[:parent_id].to_s).children
  end
  
  def item_blog
    @item = Item.find(params[:id])
    @blogs = Blog.where(item_id: @item)
  end

  private

  def item_params
    params.require(:item).permit(:shop_id, :name, :introduction, :size, :shipping_date, :price, :category_id, :is_active, :limit, item_images: [])
  end
  
  def set_parents
    @set_parents = Category.where(ancestry: nil)
  end

end
