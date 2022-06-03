class Public::CustomersController < ApplicationController

  before_action :authenticate_customer!

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
    unless @customer.shop.blank?
      @shop = @customer.shop
    end
    @checks = current_customer.passive_checks.where(checked: false)
    @notices = current_customer.passive_notices.where(checked: false)
  end

  def edit
    @customer = current_customer
    unless current_customer == @customer
      redirect_to root_path
    end
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = "会員情報の編集に成功しました。"
      redirect_to my_page_path(@customer)
    else
      render :edit
    end
  end

  def profile_edit
    @customer = current_customer
    unless current_customer == @customer
      redirect_to root_path
    end
  end

  def profile_update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = "プロフィールの編集に成功しました。"
      redirect_to my_page_path(@customer)
    else
      render :profile_edit
    end
  end

  def favourite_blog
    @favourite_blogs = current_customer.favourite_blogs.all
  end

  def favourite_item
    @favourite_items = current_customer.favourite_items.all
  end

  def favourite_shop
    @favourite_shops = current_customer.favourite_shops.all
  end
  
  def customer_blog
    @customer = Customer.find(params[:id])
    @blogs = @customer.blogs
  end
  
  def followers
    customer = Customer.find(params[:customer_id])
    @customers = customer.followings
  end
  
  def followings
    customer = Customer.find(params[:customer_id])
    @customers = customer.followers
  end

  def unsubscribe
    @customer = Customer.find_by(email: params[:email])
  end

  def withdraw
    @customer = current_customer
    @shop = current_customer.shop
    @customer.update(is_deleted: true)
      @shop.update(is_active: false)
        @shop.items.each do |item|
          item.update(is_active: false)
        end
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:user_name,
                                     :introduction,
                                     :last_name,
                                     :first_name,
                                     :last_name_kana,
                                     :first_name_kana,
                                     :email,
                                     :encrypted_password,
                                     :postal_code,
                                     :address,
                                     :telephone_number,
                                     :is_deleted)
  end

end
