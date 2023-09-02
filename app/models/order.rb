class Order < ApplicationRecord
  include AASM

  with_options if: :deduct? do |admin|
    admin.validates :remark, presence: true
  end

  with_options if: :increase? do |admin|
    admin.validates :remark, presence: true
  end

  with_options if: :bonus? do |admin|
    admin.validates :remark, presence: true
  end

  scope :filter_by_serial_number, -> (serial_number) { where serial_number: serial_number }
  scope :filter_by_email, -> (email) { includes(:user).where(user: { email: email }) }
  scope :filter_by_state, -> (genre) { where genre: genre }
  scope :filter_by_state, -> (state) { where state: state }
  scope :filter_by_state, -> (offer) { where offer: offer }
  scope :filter_by_start_date, -> (start_date) { where("offline_at >= (?)", start_date) }
  scope :filter_by_end_date, -> (end_date) { where("offline_at < (?)", end_date) }

  belongs_to :offer, optional: true
  belongs_to :user

  after_create :assign_serial_number

  enum genre: { deposit: 0, increase: 1, deduct: 2, bonus: 3, share: 4 }

  aasm column: :state do
    state :pending, initial: true
    state :submitted, :cancelled, :paid

    event :submit do
      transitions from: :pending, to: :paid, unless: :deposit?
      transitions from: :pending, to: :submitted
    end

    event :pay do
      transitions from: :submitted, to: :paid, guard: :can_deduct_after_pay?, after: [:update_coins_after_pay, :increase_total_deposit_after_pay]
      transitions from: :pending, to: :paid, after: :update_coins_after_pay, unless: :deposit?
    end

    event :cancel do
      transitions from: :paid, to: :cancelled, guard: :can_deduct_after_cancel?, after: [:update_coins_after_cancel, :decrease_total_deposit_after_cancel]
      transitions from: [:pending, :submitted], to: :cancelled
    end
  end

  def assign_serial_number
    number_count = user.orders.count.to_s
    date = Time.current.strftime('%y%m%d')
    self.update(serial_number: "#{date}-#{id}-#{user.id}-#{number_count.rjust(4, '0')}")
  end

  def can_deduct_after_cancel?
    (!deduct? && user.coins > coin) || deduct?
  end

  def can_deduct_after_pay?
    (deduct? && user.coins > coin) || !deduct?
  end

  def update_coins_after_cancel?
    if !deduct?
      user.update(coins: user.coin - coin)
    elsif deduct?
      user.update(coins: user.coin + coin)
    end
  end

  def decrease_total_deposit_after_cancel?
    if deposit?
      user.update(total_deposit: user.total_deposit - amount)
    end
  end

  def update_coins_after_pay
    if !deduct?
      user.update(coins: user.coins + coin)
    elsif deduct?
      user.update(coins: user.coins - coin)
    end
  end

  def increase_total_deposit_after_pay
    if deposit?
      user.update(total_deposit: user.total_deposit + amount)
    end
  end

end