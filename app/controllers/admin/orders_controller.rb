class Admin::OrdersController < ApplicationController
  
  # skip_before_action :authenticate_customer!, only: [:update]
  # before_action :authenticate_admin!, only: [:index, :show, :update]

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = @order_details.inject(0) { |sum, item| sum + item.subtotal }
  end

  def index
    @order_page = Order.all
    @orders = params[:customer_id].present? ? Customer.find(params[:customer_id]).orders : Order.all
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:notice] = "オーダーステータスを変更しました。"
      redirect_to admin_order_path(@order)
    end
  end

  private

  def order_params
    params.require(:order).permit(:shop_id, :customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end
  
end
