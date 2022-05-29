class OrderDetail < ApplicationRecord
  
  belongs_to :order
  belongs_to :item
  
  def subtotal
    price*amount
  end
  
end
