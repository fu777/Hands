class Blog < ApplicationRecord
  
  validates :title, presence: true
  validates :body, presence: true

default_scope -> { order(created_at: :desc) }
  belongs_to :customer
  belongs_to :item, optional: true
  has_many :blog_comments, dependent: :destroy
  has_many :favourite_blogs, dependent: :destroy
  has_many :notices, dependent: :destroy

  has_many_attached :blog_images
  
  def get_blog_images
    unless blog_images.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      blog_images.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    blog_images
  end
  
  def was_favourite_blog_by?(customer)
    favourite_blogs.exists?(customer_id: customer.id)
  end
  
  def create_notice_favourite_blog!(current_customer)
    temp = Notice.where(["visitor_id = ? and visited_id = ? and blog_id = ? and action = ? ", current_customer.id, customer_id, id, 'favourite_blog'])
    if temp.blank?
      notice = current_customer.active_notices.new(
        blog_id: id,
        visited_id: customer_id,
        action: 'favourite_blog'
      )
      if notice.visitor_id == notice.visited_id
        notice.checked = true
      end
      notice.save if notice.valid?
    end
  end
  
  def create_notice_blog_comment!(current_customer, blog_comment_id)
    temp_ids = BlogComment.select(:customer_id).where(blog_id: id).where.not(customer_id: current_customer.id).distinct
    temp_ids.each do |temp_id|
      save_notice_blog_comment!(current_customer, blog_comment_id, temp_id['customer_id'])
    end
    save_notice_blog_comment!(current_customer, blog_comment_id, customer_id) if temp_ids.blank?
  end

  def save_notice_blog_comment!(current_customer, blog_comment_id, visited_id)
    notice = current_customer.active_notices.new(
      blog_id: id,
      blog_comment_id: blog_comment_id,
      visited_id: visited_id,
      action: 'blog_comment'
    )
    if notice.visitor_id == notice.visited_id
      notice.checked = true
    end
    notice.save if notice.valid?
  end
  
  def self.search(search)
    if search
      Blog.where(["title LIKE?", "%#{search}%"])
    end
  end
  
end
