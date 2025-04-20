class HeatmapsController < ApplicationController
  before_action :authenticate_user!

  include ApplicationHelper
  MOOD_MAP = {
    "ホッと" => 40,
    "ワクワク" => 30,
    "モヤモヤ" => 20,
    "ムカムカ" => 10,
    "その他" => 0
  }
  def heatmap_data
    if current_user
    data = current_user.colors.map do |color|
      mood_score = MOOD_MAP[color.mood] || 0
      {
        x: color.created_at.to_date,
        y: mood_score
      }
    end
      render json: data
    else
      render json: [], status: :unauthorized
    end
  end
end
