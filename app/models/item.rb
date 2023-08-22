class Item < ApplicationRecord
  include AASM
  default_scope { where(deleted_at: nil) }

  has_many :item_category_ships
  has_many :categories, through: :item_category_ships
  has_many :winners
  has_many :bets

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
      transitions from: :starting, to: :ended, if: :minimum_bets_reached?, success: :pick_winner
    end

    event :cancel do
      transitions from: [:starting, :paused], to: :cancelled, after: :cancel_bet

    end
  end

  def deduct_quantity
    update(quantity: (quantity) - 1, batch_count: (batch_count) + 1)
  end

  def cancel_bet
    bets.each do |bet|
      bet.cancel!
    end
  end

  def quantity_enough?
    quantity > 0
  end

  def date_today?
    Date.current < offline_at
  end

  def minimum_bets_reached?
    bets.where(batch_count: batch_count).betting.count >= minimum_bets
  end

  def pick_winner
    winner = bets.where(batch_count: batch_count).betting.sample
    winner.win!
    bets.excluding(winner).each do |bet|
      bet.lose!
    end
    Winner.create(bet: winner, user: winner.user, item: self, item_batch_count: self.batch_count)
  end
end