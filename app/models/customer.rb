class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :user_name, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true

  has_one :shop
  has_many :blogs, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :blog_comments, dependent: :destroy
  has_many :goods, dependent: :destroy
  has_many :favourite_items, dependent: :destroy
  has_many :favourite_shops, dependent: :destroy

  enum is_deleted: {true: true, false: false}
  
  has_one_attached :customer_image

  def get_image(width, height)
    unless customer_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      customer_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    customer_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def address_display
    '〒' + postal_code + ' ' + address + ' ' + last_name + first_name
  end
  
end
