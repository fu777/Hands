class Public::HomesController < ApplicationController
  
  def top
    @item_ranks = Item.create_item_ranks
    @shop_ranks = Shop.create_shop_ranks
    @blog_ranks = Blog.create_blog_ranks
    @items = Item.limit(3).order(created_at: :desc).where(is_active: true)
    @shops = Shop.limit(3).order(created_at: :desc).where(is_active: true)
    @blogs = Blog.limit(3).order(created_at: :desc)
  end

  def about
  end
  
end
