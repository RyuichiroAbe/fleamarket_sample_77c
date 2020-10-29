# README

## usersテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|mail|string|null: false, unique: true|
|password|string|null: false|

### Association
has_many :items, dependent: :destroy
has_many :comments, dependent: :destroy
has_one :profile, dependent: :destroy
has_one :sending_destination, dependent: :destroy
has_one :card, dependent: :destroy

## profilesテーブル

|Column|Type|Options|
|------|----|-------|
|first_name|string|null:false|
|family_name|string|null:false|
|first_name_kana|string|null:false|
|family_name_kana|string|null:false|
|birth_day|date|null:false|
|introduction|text|
|user|references|null:false,foreign_key:true|

### Association
belongs_to :user

## itemsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
|introduction|text|null:false|
|price|integer|null:false|
|brand|text|null:false|
|item_condition_id(acitve_hash)|integer|null:false|
|postage_payer_id(acitve_hash)|integer|null:false|
|prefecture_code_id(acitve_hash)|integer|null:false|
|preparation_day_id(acitve_hash)|integer|null:false|
|category|references|null:false,foreign_key:true|
|trading_status|integer|
|seller|references|null:false,foreign_key:true|
|buyer|references|foreign_key:true|

### Association
has_many :comments, dependent: :destroy
has_many :favorites, dependent: :destroy
has_many :item_imgs, dependent: :destroy
belongs_to :category
belongs_to :user

### purchased_itemsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null:false,foreign_key:true|
|item_id|references|null:false,foreign_key:true|

### Association
belongs_to :user
belongs_to :item

### sending_destinationsテーブル
|Column|Type|Options|
|------|----|-------|
|destination_first_name|string|null:false|
|destination_family_name|string|null:false|
|destination_first_name_kana|string|null:false|
|destination_family_name_kana|string|null:false|
|post_code|integer|null:false|
|prefecture_code|integer|null:false|
|city|string|null:false|
|house_number|string|null:false|
|building_name|string|
|phone_number|string|unique:true|
|user|references|null:false,foreign_key:true|

### Association
belongs_to:user

## items_imgテーブル

|Column|Type|Options|
|------|----|-------|
|item|references|null:false,foreign_key:true|
|url|string|null:false|

### Association
belongs_to :item

## commentsテーブル

|Column|Type|Options|
|------|----|-------|
|comment|text|null:false|
|user|references|null:false,foreign_key:true|
|item|references|null:false,foreign_key:true|

### Association
belongs_to :user
belongs_to :item

## cardsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null:false,foreign_key:true|
|customer_id|string|null:false|
|card_token|string|null:false,unique:true|

### Association
belongs_to: user

## categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
|ancestry|string|null:false|

### Association
has_many :items
