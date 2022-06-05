class Admin::ReviewsController < ApplicationController
  
  skip_before_action :authenticate_customer!, only: [:destroy]
  before_action :authenticate_admin!, only: [:index, :destroy]

  def index
    @reviews = Review.all
  end

  def destroy
    Review.find(params[:id]).destroy
    redirect_to admin_reviews_path
  end
  
end
