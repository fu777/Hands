class Public::BlogsController < ApplicationController

  def new
    @blog = Blog.new
    @blog.customer_id = current_customer.id
    @items = Item.all
  end

  def create
    @blog = Blog.new(blog_params)
    @items = Item.all
    if @blog.save
      flash[:notice] = "ブログを新規登録しました。"
      redirect_to blog_path(@blog)
    else
      render :new
    end
  end

  def index
    @blogs = params[:item_id].present? ? Blog.where(item_id: nil) : Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
    @item = @blog.item
    @blog_comment = BlogComment.new
  end

  def edit
    @blog = Blog.find(params[:id])
    @items = Item.all
  end

  def update
    @blog = Blog.find(params[:id])
    @items = Item.all
    if @blog.update(blog_params)
      flash[:notice] = "ブログを編集しました。"
      redirect_to blog_path(@blog)
    else
      render :edit
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :body, :customer_id, :item_id, blog_images: [])
  end

end
