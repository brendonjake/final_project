class Address::Region < ApplicationRecord
  validates :name, presence: true
  validates :code, uniqueness: true

  has_many :provinces
  belongs_to :address, class_name: 'Address', foreign_key: 'address_region_id'
end
