class Relationship < ApplicationRecord
  
  belongs_to :customer
  belongs_to :follow, class_name: "Customer"
  
end
