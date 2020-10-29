class CreateSendingDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :sending_destinations do |t|
      t.integer :post_code,          null:false
      t.integer :prefecture_code_id,  null:false
      t.string  :city,             null:false
      t.string  :house_number,     null:false
      t.string  :building_name
      t.string  :phone_number,     unique:true

      t.references	:user,         null:false,foreign_key:true
      t.timestamps
    end
  end
end
