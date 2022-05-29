class Cart < ApplicationRecord
  
  belongs_to :customer
  belongs_to :shop
  has_many :cart_items, dependent: :destroy
  
end
