class Admin::OrdersController < ApplicationController

  skip_before_action :authenticate_customer!, only: [:update]
  before_action :authenticate_admin!, only: [:index, :show, :update]

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = @order_details.inject(0) { |sum, item| sum + item.subtotal }
  end

  def index
    @orders = params[:customer_id].present? ? Customer.find(params[:customer_id]).orders.order(created_at: :desc) : Order.all.order(created_at: :desc)
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:notice] = "オーダーステータスを変更しました。"
      if @order.status == 'waiting_for_delivery'
        @order.checks.destroy_all
        @order.create_check_first_order!(@order.customer)
      elsif @order.status == 'receipt_confirmation'
        @order.checks.destroy_all
        @order.create_check_shop_order!(@order.shop_id, @order.id, @order.customer_id)
      else
        @order.checks.destroy_all
        @order.create_check_order!(@order.customer)
      end
      redirect_to admin_order_path(@order)
    end
  end

  private

  def order_params
    params.require(:order).permit(:shop_id, :customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end
