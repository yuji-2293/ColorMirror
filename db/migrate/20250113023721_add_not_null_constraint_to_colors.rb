class AddNotNullConstraintToColors < ActiveRecord::Migration[8.0]
  def change
    change_column_null :colors, :user_id, false
    change_column_null :colors, :color_name, false
  end
end
