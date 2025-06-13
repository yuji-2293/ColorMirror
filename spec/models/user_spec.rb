require 'rails_helper'

RSpec.describe User, type: :model do
subject(:user) { build(:user) }

it { is_expected.to validate_presence_of(:name) }

    context "Userバリデーションの機能テスト" do
      it "設定したバリデーションが機能しているか" do
        user = build(:user)
        expect(user).to be_valid
        expect(user.errors).to be_empty
      end
      it "DBにユーザーを作成して、メール認証をパスしたときバリデーションが機能しているか" do
        user = create(:user, confirmed_at: Time.current)
        expect(user).to be_valid
        expect(user.errors).to be_empty
      end
    end
end
