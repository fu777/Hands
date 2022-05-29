class Admin::ItemsController < ApplicationController

  # before_action :authenticate_admin!, only: [:index, :show]

  def index
    @items = Item.all
    @active_items = Item.where(is_active: "true")
  end

  def show
    @item = Item.find(params[:id])
  end
  
  private

  def item_params
    params.require(:item).permit(:shop_id, :name, :introduction, :size, :shipping_date, :price, :category_id, :is_active, item_images: [])
  end
  
end
