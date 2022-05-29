class Public::BlogCommentsController < ApplicationController
  
  before_action :authenticate_customer!, only: [:create, :destroy]

  def create
    blog = Blog.find(params[:blog_id])
    comment = current_customer.blog_comments.new(blog_comment_params)
    comment.blog_id = blog.id
    comment.save
    redirect_to blog_path(blog)
  end

  def destroy
    BlogComment.find(params[:id]).destroy
    redirect_to blog_path(params[:blog_id])
  end

  private

  def blog_comment_params
    params.require(:blog_comment).permit(:comment)
  end
  
end
