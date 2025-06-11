class ResultMapsController < ApplicationController
  before_action :authenticate_user!

  def heatmap_data
    if current_user
      data = current_user.self_logs.includes(:weather_log).map(&:weather_log)
    weather  =  data.map { |log|
        {
          x: log.created_at.to_date,
          y: log.weather_score
        }
      }
      render json: weather
    else
      render json: [], status: :unauthorized
    end
  end

  def map_data
    if current_user
      start_date = Date.today.beginning_of_week
      end_date = Date.today.end_of_week
      current_week = current_user.colors.where(created_at: start_date..end_date).order(:created_at)

      last_week_start = 1.week.ago.to_date.beginning_of_week
      last_week_end   = 1.week.ago.to_date.end_of_week
      last_week = current_user.colors.where(created_at: last_week_start..last_week_end).order(:created_at)

    render json: {
      current_scores: normalize_week(current_week),
      last_scores: normalize_week(last_week)
    }

    end
  end

  private

  # 曜日付きの配列
  def normalize_week(data)
    weekdays = %w[日 月 火 水 木 金 土]
    mood_map = data.index_by { |m| m.created_at.wday }  # wday: 0(日)〜6(土)

    (0..6).map do |wday|
      color = mood_map[wday]
      {
        day: weekdays[wday],
        score: color&.mood_score || 0  # データない日は0
      }
    end
  end
end
