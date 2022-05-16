class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User', counter_cache: true

  validates :title, presence: true
  validates :title, length: { maximum: 250 }

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
