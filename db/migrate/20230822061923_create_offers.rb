class CreateOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :offers do |t|
      t.string :image
      t.string :name
      t.integer :genre
      t.integer :status, default: 0
      t.integer :amount
      t.integer :coin, default: 0
      t.timestamps
    end
  end
end
