class Public::OrdersController < ApplicationController

  # before_action :authenticate_customer!, only: [:index, :show]

  def new
    @customer = current_customer
    @cart = @customer.carts.find_by(shop_id: params[:shop_id])
    @cart.cart_items.each do |cart_item|
      if cart_item.item.limit == 0
        flash[:alert] = "売り切れた作品があります。カートから削除してください。"
        redirect_to carts_path(@customer)
      end
    end
    @order = Order.new
    @shop_id = params[:shop_id]
  end

  def confirm
    @order = Order.new(order_params)
    @new_order = Order.new
    @shop_id = params[:order][:shop_id]
    @cart = current_customer.carts.find_by(shop_id: @shop_id)
    @total = @cart.cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @shipping_cost = 800
    @total_payment = @total + @shipping_cost
    @order.customer = current_customer
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      unless @order.valid?
        @customer = current_customer
        render :new
      end
    end
  end

  def complete
  end

  def create
    @cart = current_customer.carts.find_by(shop_id: params[:order][:shop_id])
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @customer = current_customer
    @order.status = 0
    @order.save
      @cart.cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.item_id = cart_item.item_id
        @order_detail.order_id = @order.id
        @order_detail.price = cart_item.item.price
        @order_detail.amount = cart_item.amount
        unless @order_detail.item.limit.nil?
          limit = @order_detail.item.limit -= 1
          @order_detail.item.update(limit: limit)
          if @order_detail.item.limit == 0
            @order_detail.item.update(is_active: false)
          end
        end
        @order_detail.save
      end
    @order.create_check_first_order!(current_customer)
    redirect_to complete_path
    @cart.destroy
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = @order_details.inject(0) { |sum, item| sum + item.subtotal }
  end

  def update
    @order = Order.find(params[:id])
    @order.status = 2
    @order.update(order_params)
    if @order.update(order_params)
      flash[:notice] = "取引完了しました"
      @order.create_check_order!(current_customer)
      checks = current_customer.passive_checks
      checks.where(checked: false).each do |check|
        check.update(checked: true)
        if check.checked == true
          check.destroy
        end
      end
      redirect_to order_path(@order)
    end
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :shop_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end
