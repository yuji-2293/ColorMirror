class User < ApplicationRecord
  before_create :generate_line_token
  extend Enumerize

  has_many :self_logs
  has_many :colors, through: :self_logs, dependent: :destroy
  has_many :responses, through: :self_logs, dependent: :destroy
  has_many :weather_logs, through: :self_logs, dependent: :destroy

  validates :name, presence: true
  validates :prefecture, presence: true

  validates :password, presence: true, on: :create
  validates :password, presence: true, length: { minimum: 6 }, allow_blank: true
  validates :email, presence: { message: "メールアドレスの入力は必須です" }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, :trackable, :confirmable,
          :timeoutable, :omniauthable, omniauth_providers: [ :google_oauth2 ]

  enum :line_alert, { no_alert: 0, need_alert: 1 }, validate: true

  def need_unconfirmed?
    pending_any_confirmation
  end

  def password_required?
    new_record? || password.present? || password_confirmation.present?
  end

  def self.from_omniauth(auth)
      data = auth.info
      user = User.find_by(email: data["email"])

    if user.blank?
      user = nil
      ActiveRecord::Base.transaction do
          user = User.new(
          email: auth.info.email,
          name: auth.info.name,
          password: Devise.friendly_token[0, 20],
          confirmed_at: Time.current,
          provider: auth.provider,
          uid: auth.uid,
          prefecture: "東京都" # デフォルト値
          )
          user.save!
      end
    end
      user
  end

    enumerize :prefecture, in: {
    北海道: 1, 青森県: 2, 岩手県: 3, 宮城県: 4, 秋田県: 5, 山形県: 6, 福島県: 7,
    茨城県: 8, 栃木県: 9, 群馬県: 10, 埼玉県: 11, 千葉県: 12, 東京都: 13, 神奈川県: 14,
    新潟県: 15, 富山県: 16, 石川県: 17, 福井県: 18, 山梨県: 19, 長野県: 20,
    岐阜県: 21, 静岡県: 22, 愛知県: 23, 三重県: 24,
    滋賀県: 25, 京都府: 26, 大阪府: 27, 兵庫県: 28, 奈良県: 29, 和歌山県: 30,
    鳥取県: 31, 島根県: 32, 岡山県: 33, 広島県: 34, 山口県: 35,
    徳島県: 36, 香川県: 37, 愛媛県: 38, 高知県: 39,
    福岡県: 40, 佐賀県: 41, 長崎県: 42, 熊本県: 43, 大分県: 44, 宮崎県: 45, 鹿児島県: 46,
    沖縄県: 47
  }, scope: true, predicates: true

  private

  def generate_line_token
    self.line_token = loop do
      random_token  = SecureRandom.hex(6)
      break random_token unless User.exists?(line_token: random_token)
    end
  end
end
