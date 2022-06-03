class FavouriteItem < ApplicationRecord
  
  default_scope -> { order(created_at: :desc) }
  belongs_to :customer
  belongs_to :item
  
end
