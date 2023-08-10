class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.references :address_region
      t.references :address_province
      t.references :address_city
      t.references :address_barangay
      t.belongs_to :user
      t.timestamps
    end
  end
end
