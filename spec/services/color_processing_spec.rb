require "rails_helper"

RSpec.describe ColorProcessingService do
  let(:prompt) { { color_name: "#ffff", mood: "わくわく" } }

  before do
    allow_any_instance_of(ColorResponseService).to receive(:fetch_response).and_return(
      { "choices" => [ { "message" => { "content" => "テストコード" } } ] }
    )
  end
  it "有効なcolor_analysis と weather_analysisが返ってくるか" do
    user = build(:user)
    color = build(:color)
    weather_data = build(:weather_log)
    service = ColorProcessingService.new(color, user).process_color(prompt, weather_data)

    expect(service).to be_a(Hash)
    expect(service[:color_analysis]).to eq("テストコード")
    expect(service[:weather_analysis]).to eq("テストコード")
  end
end
