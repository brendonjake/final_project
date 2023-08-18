class AddDefaultToUserCoins < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :coins
    add_column :users, :coins, :integer, default: 0
  end
end
