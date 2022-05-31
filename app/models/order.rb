class Order < ApplicationRecord
  
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  
  belongs_to :customer
  belongs_to :shop
  has_many :order_details
  has_many :notices, dependent: :destroy

  enum payment_method: {credit_card: 0, transfer: 1}
  enum status: {waiting_for_delivery: 0,
                receipt_confirmation: 1,
                transaction_completed: 2}

  def create_notice_shop_order!(shop_id, order_id, customer_id)
    notice = shop.shop_active_notices.new(
      shop_visitor_id: shop_id,
      order_id: id,
      visited_id: customer_id,
      action: 'transaction_completed'
    )
    notice.save if notice.valid?
  end
  
  def create_notice_order!(customer_id, order_id, shop_id)
    notice = current_customer.active_notices.new(
      visitor_id: customer_id,
      order_id: id,
      shop_visited_id: shop_id,
      action: 'transaction_completed'
    )
    notice.save if notice.valid?
  end
  
end
