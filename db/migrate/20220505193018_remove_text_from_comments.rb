class RemoveTextFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :text, :string
  end
end
