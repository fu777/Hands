class Item < ApplicationRecord
  
  validates :category_id, presence: true
  validates :shop_id, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :size, presence: true
  validates :shipping_date, presence: true
  validates :price, presence: true
  validates :is_active, presence: true
  
  belongs_to :shop
  has_many :categories
  has_many :blogs, dependent: :destroy
  has_many :cart_items
  has_many :order_details, dependent: :destroy
  has_many :favourite_items, dependent: :destroy
  
  has_many_attached :item_images
  
  def get_item_images
    unless item_images.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      item_images.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    item_images
  end
  
  def favourited_item_by?(customer)
    favourite_items.exists?(customer_id: customer.id)
  end
  
  def self.search(search)
    if search
      Item.where(["name LIKE?", "%#{search}%"])
    end
  end

  enum is_active: {true: true, false: false}
  
end
