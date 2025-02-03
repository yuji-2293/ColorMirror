class RenameWeatherLogAndAddColumns < ActiveRecord::Migration[8.0]
  def change
    rename_column :weather_logs,  :whether_condition, :weather_name
    remove_column :weather_logs, :fetched_at

    add_column :weather_logs, :temp_max, :integer
    add_column :weather_logs, :temp_min, :integer
    add_column :weather_logs, :weather_icon, :string
  end
end
