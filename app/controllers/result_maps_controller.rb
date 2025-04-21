class ResultMapsController < ApplicationController
  before_action :authenticate_user!

  def heatmap_data
    if current_user
    data = current_user.colors.map do |color|
      {
        x: color.created_at.to_date,
        y: color.mood_score
      }
    end
      render json: data
    else
      render json: [], status: :unauthorized
    end
  end

  def radar_map_data
    if current_user
      # 1週間分のレコードを取得
      week_colors = current_user.colors.where("colors.created_at >= ?", 6.days.ago.beginning_of_day)
      mood_score = week_colors.map do |color|
      {
      mood: color.mood,
      score: color.mood_score
      }
      end
render json: mood_score
    end
  end
end
