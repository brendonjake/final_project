class Bet < ApplicationRecord
  include AASM
  scope :filter_by_serial_number, -> (serial_number) { where serial_number: serial_number }
  scope :filter_by_item_name, -> (item_name) { includes(:item).where(item: {name: item_name}) }
  scope :filter_by_email, -> (email) { includes(:user).where(user: {email: email }) }
  scope :filter_by_state, -> (state) { where state: state }
  scope :filter_by_start_date, -> (start_date) { where("offline_at >= (?)", start_date)}
  scope :filter_by_end_date, -> (end_date) { where("offline_at < (?)", end_date) }

  belongs_to :item
  belongs_to :user
  after_create :deduct_user_coins
  aasm column: :state do
    state :betting, initial: true
    state :won, :lost, :cancelled

    event :win do
      transitions from: :betting, to: :won
    end

    event :lose do
      transitions from: :betting, to: :lost
    end

    event :cancel do
      transitions from: :betting, to: :cancelled, after: :coin_refund
    end
  end

  def coin_refund
    user.update(coins: user.coins + 1)
  end

  def deduct_user_coins
      user.update(coins: user.coins - 1)
  end
end
