class RemoveMoodLevelFromColors < ActiveRecord::Migration[8.0]
  def change
    remove_column :colors, :mood_level, :bigint
    remove_column :colors, :selected_at, :datetime
  end
end
