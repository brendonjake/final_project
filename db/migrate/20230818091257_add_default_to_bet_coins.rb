class AddDefaultToBetCoins < ActiveRecord::Migration[7.0]
  def change
    remove_column :bets, :coins, :integer, default: 0
    add_column :bets, :coins, :integer, default: 1
  end
end
