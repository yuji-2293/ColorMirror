class ReAttribute < ActiveRecord::Migration[8.0]
  def change
    change_column :colors, :color_id, :integer, using: 'color_id::integer'
  end
end
