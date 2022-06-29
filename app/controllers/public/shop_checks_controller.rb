class Public::ShopChecksController < ApplicationController
  
  def index
    @shop = Shop.find(params[:shop_id])
    unless current_customer == @shop.customer
      redirect_to root_path
    end
    @shop_checks = @shop.shop_passive_checks
  end
  
end
