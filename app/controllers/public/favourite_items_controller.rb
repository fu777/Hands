class Public::FavouriteItemsController < ApplicationController
  
  # before_action :authenticate_customer!, only: [:create, :destroy]
  
  def create
    item = Item.find(params[:item_id])
    favourite_item = current_customer.favourite_items.new(item_id: item.id)
    favourite_item.save
    redirect_to item_path(item)
  end

  def destroy
    item = Item.find(params[:item_id])
    favourite_item = current_customer.favourite_items.find_by(item_id: item.id)
    favourite_item.destroy
    redirect_to item_path(item)
  end
  
end
