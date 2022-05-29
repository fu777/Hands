class Admin::BlogsController < ApplicationController

  # before_action :authenticate_admin!, only: [:index, :show, :destroy]
  
  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
    @item = @blog.item
    @blog_comment = BlogComment.new
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to admin_blogs_path
  end
  
  def blog_params
    params.require(:blog).permit(:title, :body, :customer_id, :item_id, blog_images: [])
  end

end
