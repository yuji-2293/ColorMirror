class RenameColors < ActiveRecord::Migration[8.0]
  def change
    rename_column :colors, :color_name, :color_id
  end
end
