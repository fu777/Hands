class Admin::ReviewsController < ApplicationController
  
  # before_action :authenticate_admin!, only: [:index, :destroy]

  def index
    @reviews = Review.all
  end

  def destroy
    Review.find(params[:id]).destroy
    redirect_to admin_reviews_path
  end
  
end
