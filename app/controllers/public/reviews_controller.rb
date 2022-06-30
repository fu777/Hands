class Public::ReviewsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    @review = current_customer.reviews.new(review_params)
    @review.item_id = item.id
    review_count = Review.where(item_id: params[:item_id]).where(customer_id: current_customer.id).count
    unless item.shop.customer == current_customer
      if review_count < 1
        unless current_customer == @review.customer
          redirect_to root_path
        else
          @review.save
          redirect_to item_path(item)
          flash[:notice] = "レビューしました。"
        end
      else
          redirect_to item_path(item)
          flash[:error] = "レビューの投稿は一度までです。"
      end
    else
        redirect_to item_path(item)
        flash[:error] = "自分の作品にはレビューできません。"
    end
  end

  private

  def review_params
    params.require(:review).permit(:item_id, :customer_id, :star, :review_comment)
  end

end
