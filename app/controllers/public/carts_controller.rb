class Public::CartsController < ApplicationController

  # before_action :authenticate_customer!, only: [:index]

  def index
    @carts = current_customer.carts.all
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    redirect_to carts_path
  end

  def destroy_all
    Cart.destroy_all
    redirect_to carts_path
  end

  def create
    @cart = current_customer.carts.build(cart_params)
    if current_customer.carts.find_by(shop_id: params[:cart][:shop_id]).present? && CartItem.find_by(item_id: params[:item]).present?
      @cart = current_customer.carts.find_by(shop_id: params[:cart][:shop_id])
      @cart_item = @cart.cart_items.find_by(item_id: params[:cart_item][:item])
      @cart_item.amount += params[:cart_item][:amount].to_i
      @cart_item.save(cart_item_params)
      redirect_to carts_path
    elsif current_customer.carts.find_by(shop_id: params[:cart][:shop_id]).present?
      @cart = current_customer.carts.find_by(shop_id: params[:cart][:shop_id])
      @cart_item = CartItem.new
      @cart_item.amount = params[:amount]
      @cart_item.item_id = params[:item]
      @cart_item.cart_id = @cart.id
      @cart_item.save
      redirect_to carts_path
    else
      @cart.save
      @cart_item = CartItem.new
      @cart_item.amount = params[:amount]
      @cart_item.item_id = params[:item]
      @cart_item.cart_id = @cart.id
      @cart_item.save
      redirect_to carts_path
    end
  end

  private

  def cart_params
    params.require(:cart).permit(:customer_id, :shop_id)
  end
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :cart_id)
  end

end
