class Public::HomesController < ApplicationController
  
  def top
    @item_ranks = Item.create_item_ranks
    @shop_ranks = Shop.create_shop_ranks
    @blog_ranks = Blog.create_blog_ranks
    @item = Item.limit(4).order(created_at: :desc).where(is_active: true)
    @shop = Shop.limit(4).order(created_at: :desc).where(is_active: true)
    @blog = Blog.limit(4).order(created_at: :desc)
  end

  def about
  end
  
end
