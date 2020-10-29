class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.text :introduction
      t.integer :price
      t.text :brand
      t.integer :item_condition_id
      t.integer :postage_payer_id
      t.integer :prefecture_code_id
      t.integer :preparation_day_id
      t.text :category_id
      t.integer :trading_status
      t.references :seller
      t.references :buyer
      t.timestamps
    end
  end
end
