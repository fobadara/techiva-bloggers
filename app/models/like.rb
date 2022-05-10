class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post
  after_save :update_like_counter

  private

  def update_like_counter
    post.increment(:likes_counter, 1)
  end
end
