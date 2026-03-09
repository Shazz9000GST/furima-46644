class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :purchases

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  NAME_REGEX     = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  KANA_REGEX     = /\A[ァ-ヶー－]+\z/

  validates :nickname, presence: true
  validates :birth_date, presence: true

  validates :first_name,  presence: true, format: { with: NAME_REGEX }
  validates :last_name,   presence: true, format: { with: NAME_REGEX }
  validates :first_name_kana, presence: true, format: { with: KANA_REGEX }
  validates :last_name_kana,  presence: true, format: { with: KANA_REGEX }

  # パスワードは「入力があるときだけ」英数字混合をチェック
  validates :password, format: { with: PASSWORD_REGEX, message: 'Include both letters and numbers' },
                       allow_nil: true

  # 6文字以上を要件として固定したいなら（Deviseに任せるなら不要）
  # validates :password, length: { minimum: 6 }, allow_nil: true
end
