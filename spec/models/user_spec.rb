require 'rails_helper'

RSpec.describe User, type: :model do
subject(:user) { build(:user) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_presence_of(:prefecture) }
  it { is_expected.to validate_presence_of(:email).with_message("メールアドレスの入力は必須です") }

  context "アソシエーション" do
    it { is_expected.to have_many(:self_logs) }
    it { is_expected.to have_many(:colors) }
    it { is_expected.to have_many(:weather_logs) }
    it { is_expected.to have_many(:responses) }
  end

  context "ユーザーが作成された時" do
    it "パスワードが必須であること" do
      user.password = nil
      user.valid?
      expect(user.errors.full_messages).to include("パスワードを入力してください", "パスワード（確認用）とパスワードの入力が一致しません")
    end
    it "パスワードが6文字未満だと無効" do
      user.password = "12345"
      user.valid?
      expect(user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
    end
    it "パスワードが入力されていれば true " do
      user = build(:user, password: "password")
      expect(user.password_required?).to be true
    end
    it "入力されていないと false" do
      user = build(:user, password: nil, password_confirmation: nil)
      allow(user).to receive(:new_record?).and_return(false)
      expect(user.password_required?).to be false
    end
    it "LINEトークンをモックで固定する" do
      allow(SecureRandom).to receive(:hex).and_return("mocked_token")
      user.line_token = SecureRandom.hex
      expect(user.line_token).to eq("mocked_token")
    end
  end



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
