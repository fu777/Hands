class Public::ShopOrdersController < ApplicationController

  before_action :authenticate_customer!, only: [:index, :show]

  def index
    @orders = params[:shop_id].present? ? Shop.find(params[:shop_id]).orders : Order.all
    @shop = Shop.find(params[:shop_id])
    unless current_customer.shop == @shop
      redirect_to root_path
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = @order_details.inject(0) { |sum, item| sum + item.subtotal }
    unless current_customer.shop == @order.shop
      redirect_to root_path
    end
    @order.shop.shop_passive_checks.where(action: 'transaction_completed').each do |check|
      if check.action == 'transaction_completed'
        check.update(checked: true)
        if check.checked == true
          check.destroy
        end
      end
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.update(order_params)
      flash[:notice] = "配送しました"
      @order.create_check_shop_order!(@order.shop_id, @order.id, @order.customer_id)
      checks = @order.shop.shop_passive_checks
      checks.where(checked: false).each do |check|
        check.update(checked: true)
        if check.checked == true
          check.destroy
        end
      end
      redirect_to shop_order_path(@order)
    end
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :shop_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end
