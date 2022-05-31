class Shop < ApplicationRecord
  
  validates :name, presence: true
  validates :introduction, presence: true
  validates :is_active, presence: true
  
  belongs_to :customer
  has_many :items
  has_many :carts, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :favourite_shops, dependent: :destroy
  has_many :shop_active_notices, class_name: 'Notice', foreign_key: 'shop_visitor_id', dependent: :destroy
  has_many :shop_passive_notices, class_name: 'Notice', foreign_key: 'shop_visited_id', dependent: :destroy

  has_one_attached :shop_image
  has_one_attached :shop_icon_image

  def get_shop_image(width, height)
    unless shop_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      shop_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    shop_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def get_shop_icon_image(width, height)
    unless shop_icon_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      shop_icon_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    shop_icon_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def favourited_shop_by?(customer)
    favourite_shops.exists?(customer_id: customer.id)
  end
  
  def self.search(search)
    if search
      Shop.where(["name LIKE?", "%#{search}%"])
    end
  end

  enum is_active: {true: true, false: false}
  
end
