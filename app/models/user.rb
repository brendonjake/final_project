class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :winners
  has_many :bets
  enum role: { client: 0, admin: 1 }
  validates :coins, numericality: {greater_than_or_equal_to: 0}
  belongs_to :parent, class_name: 'User', optional: true, counter_cache: :children_member
  has_many :children, class_name: 'User', foreign_key: 'parent_id'
  has_many :orders

  validates :phone, phone: {
    possible: true,
    allow_blank: true,
    types: %i[voip mobile],
    countries: [:ph]
  }
  has_many :addresses
end
