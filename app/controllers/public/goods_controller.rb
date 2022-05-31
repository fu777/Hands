class Public::GoodsController < ApplicationController
  
  # before_action :authenticate_customer!, only: [:create, :destroy]
  
  def create
    blog = Blog.find(params[:blog_id])
    good = current_customer.goods.new(blog_id: blog.id)
    good.save
    blog.create_notice_good!(current_customer)
    redirect_to blog_path(blog)
  end

  def destroy
    blog = Blog.find(params[:blog_id])
    good = current_customer.goods.find_by(blog_id: blog.id)
    good.destroy
    redirect_to blog_path(blog)
  end

  
end
