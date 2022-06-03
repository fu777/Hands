class Admin::BlogCommentsController < ApplicationController
  
  def destroy
    BlogComment.find(params[:id]).destroy
    redirect_to admin_blog_path(params[:blog_id])
  end

  private

  def blog_comment_params
    params.require(:blog_comment).permit(:comment)
  end
  
end
