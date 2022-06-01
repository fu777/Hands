class Public::ShopChecksController < ApplicationController
  
  def index
    @shop = Shop.find(params[:shop_id])
    @shop_checks = @shop.shop_passive_checks
  end
  
end
