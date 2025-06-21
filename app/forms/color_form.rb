class ColorForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  # 親モデルの属性
  attribute :color_name, :string
  attribute :mood, :string
  # 子モデルの属性(中間)
  attribute :color_id, :integer
  attribute :user_id, :integer
  # 子モデルの属性(weather_log)
  attribute :city, :string
  attribute :weather_name, :string
  attribute :description, :string
  attribute :temperature, :integer
  attribute :temp_max, :integer
  attribute :temp_min, :integer
  attribute :weather_pressure, :integer
  attribute :weather_icon, :string
  # 子モデルの属性(response)
  attribute :color_analysis, :string
  attribute :weather_analysis, :string

  validates :color_name, presence: true
  validates :city, presence: true

  attr_reader :color
  delegate :persisted?, to: :color



  def initialize(attributes = nil, color: Color.new, ai_comment: nil)
    @color = color
    super(attributes)
  end

  def save
    return if invalid?
    ActiveRecord::Base.transaction do
      if @color.persisted?
        @color.update!(color_name: color_name, mood: mood)
      else
        @color = Color.create!(color_name: color_name, mood: mood)
      end
      self_log = @color.self_logs.find_or_create_by(user_id: user_id, color_id: @color.id)

      self_log.create_response!(
        color_analysis: nil,
        weather_analysis: nil
        )

      weather_log = self_log.weather_log || self_log.build_weather_log
      weather_log.update!(city: city, weather_name: weather_name, description: description,
      temperature: temperature, temp_max: temp_max, temp_min: temp_min,
      weather_pressure: weather_pressure, weather_icon: weather_icon)
    end
    true
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("save時のエラーを出力: #{e.message}")
    false
  end
end
