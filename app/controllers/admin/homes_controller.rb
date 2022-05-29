class Admin::HomesController < ApplicationController
  
  # before_action :authenticate_admin!, only: [:top]

  def top
    @orders = Order.all
  end
  
end
