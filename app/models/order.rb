class Order < ApplicationRecord
  
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  
  belongs_to :customer
  belongs_to :shop
  has_many :order_details

  enum payment_method: {credit_card: 0, transfer: 1}
  enum status: {waiting_for_delivery: 0,
                receipt_confirmation: 1,
                transaction_completed: 2}
  
end
