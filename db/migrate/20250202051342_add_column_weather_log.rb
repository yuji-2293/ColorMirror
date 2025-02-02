class AddColumnWeatherLog < ActiveRecord::Migration[8.0]
  def change
    add_column :weather_logs, :city, :string
  end
end
