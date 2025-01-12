class AddColorNameToColors < ActiveRecord::Migration[8.0]
  def change
    add_column :colors, :user_id, :int
    add_column :colors, :color_name, :string
    add_column :colors, :mood_level, :int
    add_column :colors, :selected_at, :datetime
  end
end
