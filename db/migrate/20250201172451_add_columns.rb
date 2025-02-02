class AddColumns < ActiveRecord::Migration[8.0]
  def change
    add_column :weather_logs, :description, :string
  end
end
