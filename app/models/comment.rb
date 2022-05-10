class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post
  after_save :update_comment_counter

  def update_comment_counter
    posts.increment(:comments_counter, 1)
  end
end
