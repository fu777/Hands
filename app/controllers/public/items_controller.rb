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
    @category_id = @item.category_id
    @category_parent = Category.find(@category_id).parent
    @category_child = Category.find(@category_id)
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
    #クリックしたカテゴリーidに紐づくレコードを取得
    @category = Category.find_by(id: params[:id])

    #親カテゴリーが選択された時
    if @category.ancestry.nil?
      #取得したレコードに紐づいた孫レコードidを.indirect_idsで取得
      # category = Category.find_by(id: params[:id]).indirect_ids
# 孫がないので
      # 取得したレコードに紐づいた子レコードidを取得
      category = Category.find_by(id: params[:id]).child_ids
# を書いている
      if category.empty?
        @items = Item.where(category_id: @category.id).order(created_at: :desc)
      else
        @items = []
        find_item(category)
      end

    #孫カテゴリーが選択された時
    # elsif @category.ancestry.include?("/")
      # @items = Item.where(category_id: params[:id]).order(created_at: :desc)
    else
# 孫がないので
      @items = Item.where(category_id: params[:id]).order(created_at: :desc)
# を書いている
    #親でも孫でもない＝子カテゴリーが選択された時
    # else
      #取得したレコードに紐づいた子レコードidを取得
      # category = Category.find_by(id: params[:id]).child_ids
      # @items = []
      # find_item(category)
    end
  @true_items = @items.where(is_active: true)
  end

  def find_item(category)
    category.each do |id|
      #子・孫レコードのidと一致するitemを取得
      item_array = Item.where(category_id: id).order(created_at: :desc)
      next unless item_array.present?

      item_array.each do |item|
        #一致して取得したitemを1つずつ取り出して@itemsに順次追加
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

  def set_parents
    @set_parents = Category.where(ancestry: nil)
  end

end
