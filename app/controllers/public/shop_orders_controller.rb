class Public::ShopOrdersController < ApplicationController
  
  # before_action :authenticate_customer!, only: [:index, :show]

  def index
    @orders = params[:shop_id].present? ? Shop.find(params[:shop_id]).orders : Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = @order_details.inject(0) { |sum, item| sum + item.subtotal }
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.update(order_params)
      flash[:notice] = "配送しました"
      redirect_to shop_order_path(@order)
    end
  end
  
  private

  def order_params
    params.require(:order).permit(:customer_id, :shop_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end
  
end
