class Blog < ApplicationRecord
  
  validates :title, presence: true
  validates :body, presence: true

  belongs_to :customer
  belongs_to :item
  has_many :blog_comments, dependent: :destroy
  has_many :goods, dependent: :destroy

  has_many_attached :blog_images
  
  def get_blog_images
    unless blog_images.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      blog_images.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    blog_images
  end
  
  def was_good_by?(customer)
    goods.exists?(customer_id: customer.id)
  end
  
end
