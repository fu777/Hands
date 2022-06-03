class FavouriteShop < ApplicationRecord
  
  default_scope -> { order(created_at: :desc) }
  belongs_to :customer
  belongs_to :shop
  
end
