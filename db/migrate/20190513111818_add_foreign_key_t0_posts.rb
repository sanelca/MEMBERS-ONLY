class AddForeignKeyT0Posts < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :posts, :users
  end
end
