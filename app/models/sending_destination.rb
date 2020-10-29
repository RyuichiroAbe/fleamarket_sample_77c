class SendingDestination < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture_code
  belongs_to :user, optional: true
  VALID_Phone_REGEX = /\A\d{10}\z|\A\d{11}\z/
  VALID_Postcode_REGEX = /\A\d{7}\z/
  
  validates :post_code, format: { with: VALID_Postcode_REGEX }
  validates :prefecture_code_id, presence: true
  validates :city, presence: true
  validates :house_number, presence: true
  # validates :building_name, presence: true
  validates :phone_number, presence: true, format: { with: VALID_Phone_REGEX }
end
