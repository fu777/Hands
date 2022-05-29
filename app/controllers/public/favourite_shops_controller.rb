class Public::FavouriteShopsController < ApplicationController
  
  # before_action :authenticate_customer!, only: [:create, :destroy]
  
  def create
    shop = Shop.find(params[:shop_id])
    favourite_shop = current_customer.favourite_shops.new(shop_id: shop.id)
    favourite_shop.save
    redirect_to shop_path(shop)
  end

  def destroy
    shop = Shop.find(params[:shop_id])
    favourite_shop = current_customer.favourite_shops.find_by(shop_id: shop.id)
    favourite_shop.destroy
    redirect_to shop_path(shop)
  end
  
end
