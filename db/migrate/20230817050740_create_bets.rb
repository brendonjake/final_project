class CreateBets < ActiveRecord::Migration[7.0]
  def change
    create_table :bets do |t|
      t.bigint :item_id
      t.bigint :user_id
      t.integer :batch_count
      t.integer :coins, default: 0
      t.string :state
      t.string :serial_number
      t.timestamps
    end
  end
end
