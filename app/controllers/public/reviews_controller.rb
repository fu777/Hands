class Public::ReviewsController < ApplicationController

  def index
    @orders = current_customer.orders
    @review = Review.new
  end

  def create
    @item = Item.find(params[:item_id])
    @review = current_customer.reviews.new(review_params)
    @review.item_id = item.id
    if @review.save
      redirect_to reviews_path
      flash[:notice] = "レビューしました。"
    else
      render :index
    end
  end

  private

  def review_params
    params.require(:review).permit(:item_id, :customer_id, :star, :review_comment)
  end

end
