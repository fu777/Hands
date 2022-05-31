class Public::ShopNoticesController < ApplicationController
  
  def index
    @notices = shop.shop_passive_notices
    @notices.where(checked: false).each do |notice|
      notice.update(checked: true)
    end
  end
  
end
