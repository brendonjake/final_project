class CreateWinners < ActiveRecord::Migration[7.0]
  def change
    create_table :winners do |t|
      t.bigint :item_id
      t.bigint :bet_id
      t.bigint :user_id
      t.bigint :address_id
      t.integer :item_batch_count
      t.string :state
      t.integer :price
      t.string :paid_at
      t.bigint :admin_id
      t.string :picture
      t.string :comment
      t.timestamps
    end
  end
end
