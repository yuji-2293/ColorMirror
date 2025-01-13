class AddForeignKeyToColors < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :colors, :users, column: :user_id
  end
end
