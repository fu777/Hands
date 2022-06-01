class Public::ChecksController < ApplicationController
  
  def index
    @checks = current_customer.passive_checks
  end
  
end
