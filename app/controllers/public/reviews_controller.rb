class Public::ReviewsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    @review = current_customer.reviews.new(review_params)
    @review.item_id = item.id
    if @review.save
      redirect_to item_path(item)
      flash[:notice] = "レビューしました。"
    else
      redirect_to item_path(item)
    end
  end

  private

  def review_params
    params.require(:review).permit(:item_id, :customer_id, :star, :review_comment)
  end

end
