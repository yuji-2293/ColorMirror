class ChangeColorsToStringInColors < ActiveRecord::Migration[8.0]
  def change
    change_column :colors, :color_name, :string
  end
end
