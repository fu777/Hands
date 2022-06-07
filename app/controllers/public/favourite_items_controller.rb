class Public::FavouriteItemsController < ApplicationController
  
  def create
    item = Item.find(params[:item_id])
    favourite_item = current_customer.favourite_items.new(item_id: item.id)
    favourite_item.save
    redirect_to request.referer
  end

  def destroy
    item = Item.find(params[:item_id])
    favourite_item = current_customer.favourite_items.find_by(item_id: item.id)
    favourite_item.destroy
    redirect_to request.referer
  end
  
end
