class RemoveTitleFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :title, :title
  end
end
