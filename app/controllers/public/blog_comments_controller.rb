class Public::BlogCommentsController < ApplicationController

  def create
    blog = Blog.find(params[:blog_id])
    comment = current_customer.blog_comments.new(blog_comment_params)
    comment.blog_id = blog.id
    unless current_customer == comment.customer
      redirect_to root_path
    else
      comment.save
      blog.create_notice_blog_comment!(current_customer, comment.id)
      redirect_to blog_path(blog)
    end
  end

  def destroy
    @blog_comment = BlogComment.find(params[:id])
    unless current_customer == @blog_comment.customer
      redirect_to root_path
    else
      @blog_comment.destroy
      redirect_to blog_path(params[:blog_id])
    end
  end

  private

  def blog_comment_params
    params.require(:blog_comment).permit(:comment)
  end

end
