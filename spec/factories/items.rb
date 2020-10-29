FactoryBot.define do
  factory :item do

    name                {"商品"}
    introduction        {"ホワイト"}
    item_condition_id   {1}
    postage_payer_id    {1}
    prefecture_code_id  {1}
    preparation_day_id  {1}
    trading_status      {1}
    price               {3000}
    brand               {"nike"}
    association :seller
    association :category
    # association :image
  end
end
