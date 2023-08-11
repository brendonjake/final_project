class AddColumnsToAddress < ActiveRecord::Migration[7.0]
  def change
    add_column :addresses, :genre, :integer, default: 0
    add_column :addresses, :name, :string
    add_column :addresses, :street_address, :string
    add_column :addresses, :phone_number, :string
    add_column :addresses, :remark, :string
    add_column :addresses, :is_default, :boolean
  end
end
