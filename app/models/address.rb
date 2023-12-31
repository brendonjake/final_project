class Address < ApplicationRecord

  validates :genre, presence: true
  validates :name, presence: true
  validates :street_address, presence: true
  validates :phone_number, presence: true
  validates :remark, presence: true
  validates :is_default, presence: true
  validates :address_region_id, presence: true
  validates :address_province_id, presence: true
  validates :address_city_id, presence: true
  validates :address_barangay_id, presence: true

  has_many :winners
  belongs_to :user
  belongs_to :province, class_name: 'Address::Province', foreign_key: 'address_province_id'
  belongs_to :city, class_name: 'Address::City', foreign_key: 'address_city_id'
  belongs_to :barangay, class_name: 'Address::Barangay', foreign_key: 'address_barangay_id'
  belongs_to :region, class_name: 'Address::Region', foreign_key: 'address_region_id'
  enum genre: { home: 0, office: 1 }

end
