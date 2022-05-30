class SearchesController < ApplicationController
  
  def item_search
    @items = Item.search(params[:search])
    @Category = Category.where(ancestry: nil)
  end
  
  def shop_search
    @shops = Shop.search(params[:search])
  end
  
  def customer_search
    @customers = Customer.search(params[:search])
  end
  
end
