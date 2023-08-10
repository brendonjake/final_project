class Address < ApplicationRecord
  has_one :region, class_name: 'Address::Region', foreign_key: 'address_region_id'
  has_one :province, class_name: 'Address::Province', foreign_key: 'address_province_id'
  has_one :city, class_name: 'Address::City', foreign_key: 'address_region_id'
  has_one :barangay, class_name: 'Address::Barangay', foreign_key: 'address_province_id'
end
