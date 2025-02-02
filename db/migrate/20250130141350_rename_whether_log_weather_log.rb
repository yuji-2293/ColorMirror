class RenameWhetherLogWeatherLog < ActiveRecord::Migration[8.0]
  def change
    rename_table :whether_logs, :weather_logs
  end
end
