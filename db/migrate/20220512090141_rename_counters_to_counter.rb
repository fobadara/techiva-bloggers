class RenameCountersToCounter < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :likes_counter, :likes_count
    rename_column :posts, :comments_counter, :comments_count
  end
end
