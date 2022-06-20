class Admin::BlogCommentsController < ApplicationController
  
  skip_before_action :authenticate_customer!, only: [:destroy]
  before_action :authenticate_admin!, only: [:index, :destroy]
  
  def index
    @blog_comments = BlogComment.all.order(created_at: :desc)
  end
  
  def destroy
    BlogComment.find(params[:id]).destroy
    redirect_to request.referer
  end

  private

  def blog_comment_params
    params.require(:blog_comment).permit(:comment)
  end
  
end
