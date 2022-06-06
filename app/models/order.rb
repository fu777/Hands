class Order < ApplicationRecord
  
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  
  belongs_to :customer
  belongs_to :shop
  has_many :order_details
  has_many :checks, dependent: :destroy

  enum payment_method: {credit_card: 0, transfer: 1}
  enum status: {waiting_for_delivery: 0,
                receipt_confirmation: 1,
                transaction_completed: 2}

  def create_check_first_order!(current_customer)
    check = current_customer.active_checks.new(
      visitor_id: customer_id,
      order_id: id,
      shop_visited_id: shop_id,
      action: 'order'
    )
    check.save if check.valid?
  end

  def create_check_shop_order!(shop_id, order_id, customer_id)
    check = shop.shop_active_checks.new(
      shop_visitor_id: shop_id,
      order_id: id,
      visited_id: customer_id,
      action: 'receipt_confirmation'
    )
    check.save if check.valid?
  end
  
  def create_check_order!(current_customer)
    check = current_customer.active_checks.new(
      visitor_id: customer_id,
      order_id: id,
      shop_visited_id: shop_id,
      action: 'transaction_completed'
    )
    check.save if check.valid?
  end
  
end
