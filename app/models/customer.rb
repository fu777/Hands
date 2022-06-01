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
  has_many :relationships
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followings, through: :relationships, source: :follow
  has_many :followers, through: :reverse_of_relationships, source: :customer
  has_many :reviews, dependent: :destroy
  has_many :active_notices, class_name: 'Notice', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notices, class_name: 'Notice', foreign_key: 'visited_id', dependent: :destroy
  has_many :active_checks, class_name: 'Check', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_checks, class_name: 'Check', foreign_key: 'visited_id', dependent: :destroy

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
  
  def self.search(search)
    if search
      Customer.where(["user_name LIKE?", "%#{search}%"])
    end
  end
  
  def follow(other_customer)
    unless self == other_customer
      self.relationships.find_or_create_by(follow_id: other_customer.id)
    end
  end

  def unfollow(other_customer)
    relationship = self.relationships.find_by(follow_id: other_customer.id)
    relationship.destroy if relationship
  end

  def following?(other_customer)
    self.followings.include?(other_customer)
  end
  
  def create_notice_follow!(current_customer)
    temp = Notice.where(["visitor_id = ? and visited_id = ? and action = ? ",current_customer.id, id, 'follow'])
    if temp.blank?
      notice = current_customer.active_notices.new(
        visited_id: id,
        action: 'follow'
      )
      notice.save if notice.valid?
    end
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.user_name = "ゲスト"
      customer.last_name = "令和"
      customer.first_name = "道子"
      customer.last_name_kana = "レイワ"
      customer.first_name_kana = "ミチコ"
      customer.postal_code = "9999999"
      customer.address = "東京都港区"
      customer.telephone_number = "9999999999"
    end
  end
  
end
