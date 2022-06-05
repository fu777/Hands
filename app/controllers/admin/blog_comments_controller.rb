class Admin::BlogCommentsController < ApplicationController
  
  skip_before_action :authenticate_customer!, only: [:destroy]
  before_action :authenticate_admin!, only: [:index, :destroy]
  
  def index
    @blog_comments = BlogComment.all
  end
  
  def destroy
    BlogComment.find(params[:id]).destroy
    if params[:blog_id].present?
      redirect_to admin_blog_path(params[:blog_id])
    else
      redirect_to admin_blog_comments_path
    end
  end

  private

  def blog_comment_params
    params.require(:blog_comment).permit(:comment)
  end
  
end
