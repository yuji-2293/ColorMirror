require 'rails_helper'

RSpec.describe SelfLog, type: :model do
  context "アソシエーション" do
    it { is_expected.to belong_to (:user) }
    it { is_expected.to belong_to (:color) }
    it { is_expected.to have_one (:response) }
    it { is_expected.to have_one (:weather_log) }
  end
end
