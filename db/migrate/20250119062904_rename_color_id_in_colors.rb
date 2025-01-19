class RenameColorIdInColors < ActiveRecord::Migration[8.0]
  def change
    rename_column :colors, :color_id, :color_name
  end
end
