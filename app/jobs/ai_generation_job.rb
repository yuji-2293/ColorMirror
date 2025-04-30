class AiGenerationJob < ApplicationJob
  queue_as :default

  def perform(prompt, weather_data, self_log_id, color_id, user_id)
    color = Color.find(color_id)
    user = User.find(user_id)
    self_log = SelfLog.find(self_log_id)
    response = self_log.response
    # AIレスポンス生成のserviceを呼び出す/必要な引数を渡す、生成したレスポンスを変数に格納
    ai_responses = ColorProcessingService.new(color, user).process_color(prompt, weather_data)
    response.update!(
    color_analysis:  ai_responses[:color_analysis],
    weather_analysis: ai_responses[:weather_analysis]
    )
    # デバッグ用にログに出力する
    Rails.logger.info "===== AI生成結果====="
    Rails.logger.info ai_responses
    Rails.logger.info "===== AI生成結果====="
    Rails.logger.info "🎉🎉🎉🎉🎉🎉🎉🎉バックグラウンド処理成功！！🎉🎉🎉🎉🎉🎉🎉🎉🎉"
  end
end
