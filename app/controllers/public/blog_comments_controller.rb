class Public::BlogCommentsController < ApplicationController

  def create
    blog = Blog.find(params[:blog_id])
    comment = current_customer.blog_comments.new(blog_comment_params)
    comment.blog_id = blog.id
    comment.save
    blog.create_notice_blog_comment!(current_customer, comment.id)
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
