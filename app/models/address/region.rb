class Address::Region < ApplicationRecord
  validates :name, presence: true
  validates :code, uniqueness: true

  has_many :provinces
  has_many :addresses, class_name: 'Address', foreign_key: 'address_region_id'

  def self.table_name_prefix
    "address"
  end
end
