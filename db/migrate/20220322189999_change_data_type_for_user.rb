class ChangeDataTypeForUser < ActiveRecord::Migration[6.1]
  def up
    change_column :users, :bio, :text
  end

  def down
    change_column :users, :bio, :string
  end
end