class RenameColumnWeatherLog < ActiveRecord::Migration[8.0]
  def change
    rename_column :weather_logs, :whether_pressure, :weather_pressure
  end
end
