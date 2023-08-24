class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.bigint :user_id
      t.bigint :offer_id
      t.string :serial_number
      t.string :state
      t.integer :amount
      t.integer :coin
      t.string :remark
      t.integer :genre
      t.timestamps
    end
  end
end
