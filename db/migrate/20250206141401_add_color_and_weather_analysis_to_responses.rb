class AddColorAndWeatherAnalysisToResponses < ActiveRecord::Migration[8.0]
  def change
    add_column :responses, :color_analysis, :string
    add_column :responses, :weather_analysis, :string
  end
end
