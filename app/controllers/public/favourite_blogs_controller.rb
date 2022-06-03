class Public::FavouriteBlogsController < ApplicationController
  
  before_action :authenticate_customer!, only: [:create, :destroy]
  
  def create
    blog = Blog.find(params[:blog_id])
    favourite_blog = current_customer.favourite_blogs.new(blog_id: blog.id)
    favourite_blog.save
    blog.create_notice_favourite_blog!(current_customer)
    redirect_to blog_path(blog)
  end

  def destroy
    blog = Blog.find(params[:blog_id])
    favourite_blog = current_customer.favourite_blogs.find_by(blog_id: blog.id)
    favourite_blog.destroy
    redirect_to blog_path(blog)
  end
  
end
