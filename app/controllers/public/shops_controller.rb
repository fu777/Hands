class Public::ShopsController < ApplicationController

  def new
    @shop = Shop.new
    @customer_id = current_customer.id
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.customer_id = current_customer.id
    unless current_customer == @shop.customer
      redirect_to root_path
    else
      if @shop.save
        redirect_to shop_path(@shop.id)
        flash[:notice] = "ショップを登録しました。"
      else
        @customer_id = current_customer.id
        render :new
      end
    end
  end

  def index
    @shops = Shop.all
  end

  def show
    @shop = Shop.find(params[:id])
    @orders = Order.where(params[:shop_id])
    @customer = @shop.customer
    @items = params[:is_active].present? ? @shop.items.where(is_active: true) : @shop.items.all
    @shop_checks = @shop.shop_passive_checks.where(checked: false)
  end

  def edit
    @shop = Shop.find(params[:id])
    unless current_customer.shop == @shop
      redirect_to root_path
    end
  end

  def update
    @shop = Shop.find(params[:id])
    unless current_customer == @shop.customer
      redirect_to root_path
    else
      if @shop.update(shop_params)
        if @shop.is_active == 'false'
          @shop.items.each do |item|
            item.update(is_active: false)
          end
        end
        flash[:notice] = "ショップを編集しました。"
        redirect_to shop_path(@shop.id)
      else
        render :edit
      end
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :introduction, :is_active, :shop_icon_image, :customer_id)
  end

end
