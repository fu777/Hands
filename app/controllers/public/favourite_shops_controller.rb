class Public::FavouriteShopsController < ApplicationController
  
  def create
    shop = Shop.find(params[:shop_id])
    favourite_shop = current_customer.favourite_shops.new(shop_id: shop.id)
    favourite_shop.save
    redirect_to request.referer
  end

  def destroy
    shop = Shop.find(params[:shop_id])
    favourite_shop = current_customer.favourite_shops.find_by(shop_id: shop.id)
    favourite_shop.destroy
    redirect_to request.referer
  end
  
end
