require 'rails_helper'

RSpec.describe Response, type: :model do
  context "アソシエーション" do
    it { is_expected.to have_one (:color) }
    it { is_expected.to have_many (:analysis_results) }
    it { is_expected.to belong_to (:self_log) }
  end
end
