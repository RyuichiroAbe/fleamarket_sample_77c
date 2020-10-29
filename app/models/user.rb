class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  # 正規表現を変数に変換
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_KANA_REGEX = /\A[ぁ-ん]+\z/

  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 7 }
  validates :nickname,:first_name,:family_name,:birth_day, presence: true
  validates :first_name_kana,:family_name_kana, presence: true, format: { with: VALID_KANA_REGEX }
  has_one :sending_destination
  has_one :card, dependent: :destroy
  has_many :items
  has_many :sns_credentials
  has_many :comments
  has_many :favorites, dependent: :destroy
  # has_many :favorites, through: :favorites, source: :item
  has_many :favorited_items, through: :favorites, source: "item"

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
      email: auth.info.email,
      password: Devise.friendly_token[0,20]
    )

    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end
