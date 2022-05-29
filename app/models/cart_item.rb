class CartItem < ApplicationRecord
  
  belongs_to :cart
  belongs_to :item

  def subtotal
    item.price*amount
  end
  
end
