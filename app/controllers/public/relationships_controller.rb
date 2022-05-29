class Public::RelationshipsController < ApplicationController
  
  before_action :set_user

  def create
    following = current_customer.follow(@customer)
    if following.save
      flash[:success] = 'ユーザーをフォローしました'
      redirect_to my_page_path(@customer)
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_to my_page_path(@customer)
    end
  end

  def destroy
    following = current_customer.unfollow(@customer)
    if following.destroy
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_to my_page_path(@customer)
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_to my_page_path(@customer)
    end
  end

  private
  
  def set_user
    @customer = Customer.find(params[:follow_id])
  end
  
end
