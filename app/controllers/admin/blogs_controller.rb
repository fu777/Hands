class Admin::BlogsController < ApplicationController

  before_action :authenticate_admin!, only: [:index, :show]
  
  def index
    @blogs = params[:item_id].present? ? Blog.where(item_id: nil) : Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
    @item = @blog.item
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
