class BlogComment < ApplicationRecord
  
  validates :comment, presence: true
  
  belongs_to :customer
  belongs_to :blog

end
