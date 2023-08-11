class Address::Province < ApplicationRecord
  validates :name, presence: true
  validates :code, uniqueness: true

  belongs_to :region
  has_many :cities
  has_many :addresses, class_name: 'Address', foreign_key: 'address_province_id'

  def self.table_name_prefix
    "address"
  end
end
