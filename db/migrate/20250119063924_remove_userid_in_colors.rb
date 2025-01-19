class RemoveUseridInColors < ActiveRecord::Migration[8.0]
  def change
    remove_column :colors, :user_id
  end
end
