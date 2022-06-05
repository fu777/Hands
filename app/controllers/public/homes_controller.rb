class Public::HomesController < ApplicationController
  
  def top
    @item_ranks = Item.create_item_ranks
    @shop_ranks = Shop.create_shop_ranks
    @blog_ranks = Blog.create_blog_ranks
  end

  def about
  end
  
end
