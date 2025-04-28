class AiGenerationJob < ApplicationJob
  queue_as :default

  def perform(prompt)
    ai_response = generate_response(prompt)
  end

  private
  def generate_response(prompt)
    "これは '#{prompt}'に基づくAI生成テキストです。 "
  end
end



    # promptとして使うデータを変数に格納
    # prompt_color = color_params[:color_name]
    # prompt_mood = params[:mood]
    # weather_data = color_params.slice(:weather_name, :weather_pressure, :temperature)
    # # AIレスポンス生成のserviceを呼び出す/必要な引数を渡す、生成したレスポンスを変数に格納
    # ai_responses = ColorProcessingService.new(@color, current_user).process_color(prompt_color, weather_data, prompt_mood)
    # @color.color_analysis = ai_responses[:color_analysis]
    # @color.weather_analysis = ai_responses[:weather_analysis]
