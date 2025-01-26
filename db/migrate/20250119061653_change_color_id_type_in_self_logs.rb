class ChangeColorIdTypeInSelfLogs < ActiveRecord::Migration[8.0]
  def change
    change_column :colors, :color_id, :bigint
    change_column :colors, :user_id, :bigint
    change_column :colors, :mood_level, :bigint
  end
end
