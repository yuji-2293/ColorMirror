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
      start_date = Date.today.beginning_of_week
      end_date = Date.today.end_of_week
      week_colors = current_user.colors.where(created_at: start_date..end_date)
      ordered_moods = [ "ホッと", "ワクワク", "わからない", "モヤモヤ", "ムカムカ" ]

      group_mood = week_colors.group(:mood).count

      scores = ordered_moods.map do |mood|
        count = group_mood[mood] || 0
        score = Color.mood_score_map[mood] * count
        [ mood, score ]
      end.to_h

      data =
      {
      mood: scores.keys,
      score: scores.values
      }

    render json: data
    end
  end
end
