class Item < ApplicationRecord

  validates :name, :introduction, :item_condition_id, :postage_payer_id, :prefecture_code_id, :preparation_day_id, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "¥300以上¥9999999以下で入力してください" }
  validates :images, presence: true, length: { in: 1..5, message: "1枚以上５枚以下選択してください" }
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :item_condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :prefecture_code
  belongs_to_active_hash :preparation_day

  has_many :images, dependent: :destroy
  has_many :purchases
  has_many :comments
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: "user"
  # has_many :favorites, through: :favorites, source: :user
  belongs_to :seller, class_name: 'User'
  # 3行目の validates の代わりに 16行目の belongs_to :category で未入力項目のバリデーションとする
  belongs_to :category

  accepts_nested_attributes_for :images, allow_destroy: true

  def self.search(search)
    return Item.all unless search
    Item.where('name LIKE(?)', "%#{search}%")
  end

end
