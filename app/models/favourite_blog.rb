class FavouriteBlog < ApplicationRecord
  
  belongs_to :customer
  belongs_to :blog
  has_many :notices, dependent: :destroy
  
end
