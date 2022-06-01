class Public::ShopChecksController < ApplicationController
  
  def index
    @checks = shop.shop_passive_checks
  end
  
end
