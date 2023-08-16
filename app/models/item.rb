class Item < ApplicationRecord
  include AASM
  default_scope { where(deleted_at: nil) }

  has_many :item_category_ships
  has_many :categories, through: :item_category_ships
  has_many :orders

  validates :name, presence: true
  validates :quantity, presence: true

  enum status: { active: 0, inactive: 1 }

  mount_uploader :image, ImageUploader

  def destroy
    update(deleted_at: Time.now)
  end

  aasm column: :state do
    state :pending, initial: true
    state :starting, :paused, :ended, :cancelled

    event :start do
      transitions from: :paused, to: :starting
      transitions from: [:pending, :ended, :cancelled], to: :starting, guard: [:quantity_enough?, :date_today?, :active?], after: :deduct_quantity
    end

    event :pause do
      transitions from: :starting, to: :paused
    end

    event :end do
      transitions from: :starting, to: :ended
    end

    event :cancel do
      transitions from: [:starting, :paused], to: :cancelled
    end
  end

  def deduct_quantity
    update(quantity: (quantity) - 1, batch_count: (batch_count) + 1)
  end

  def quantity_enough?
    quantity > 0
  end

  def date_today?
    Date.current < offline_at
  end

end