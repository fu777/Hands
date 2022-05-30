class Review < ApplicationRecord
  
  validates :review_comment, presence: true
  
  belongs_to :customer
  belongs_to :item
  
end
