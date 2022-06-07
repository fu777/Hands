class Public::FavouriteBlogsController < ApplicationController
  
  def create
    blog = Blog.find(params[:blog_id])
    favourite_blog = current_customer.favourite_blogs.new(blog_id: blog.id)
    favourite_blog.save
    blog.create_notice_favourite_blog!(current_customer)
    redirect_to request.referer
  end

  def destroy
    blog = Blog.find(params[:blog_id])
    favourite_blog = current_customer.favourite_blogs.find_by(blog_id: blog.id)
    favourite_blog.destroy
    redirect_to request.referer
  end
  
end
