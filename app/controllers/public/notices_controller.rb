class Public::NoticesController < ApplicationController
  
  def index
    @passive_notices = current_customer.passive_notices
    @passive_notices.where(checked: false).each do |notice|
      notice.update(checked: true)
    end
    @notices = @passive_notices.where.not(visitor_id: current_customer.id)
  end
  
end
