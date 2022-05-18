class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :author, class_name: 'User', counter_cache: true

  validates :title, presence: true
  validates :title, length: { maximum: 250 }

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
