class Winner < ApplicationRecord

  belongs_to :item
  belongs_to :bet
  belongs_to :admin, class_name: 'User', foreign_key: 'admin_id', optional: true
  belongs_to :user
  belongs_to :address, optional: true

  mount_uploader :picture, ImageUploader

  include AASM
  scope :filter_by_serial_number, -> (serial_number) { where serial_number: serial_number }
  scope :filter_by_email, -> (email) { includes(:user).where(user: { email: email }) }
  scope :filter_by_state, -> (state) { where state: state }
  scope :filter_by_start_date, -> (start_date) { where("offline_at >= (?)", start_date) }
  scope :filter_by_end_date, -> (end_date) { where("offline_at < (?)", end_date) }

  aasm column: :state do
    state :won, initial: true
    state :claimed, :submitted, :paid, :shipped, :delivered, :shared, :published, :remove_published


    event :claim do
      transitions from: :won, to: :claimed
    end

    event :submit do
      transitions from: :claimed, to: :submitted
    end

    event :pay do
      transitions from: :submitted, to: :paid
    end

    event :ship do
      transitions from: :paid, to: :shipped
    end

    event :deliver do
      transitions from: :shipped, to: :delivered
    end

    event :share do
      transitions from: :delivered, to: :shared
    end

    event :publish do
      transitions from: :shared, to: :published
    end

    event :remove_publish do
      transitions from: :published, to: :remove_published
    end

    event :re_publish do
      transitions from: :remove_published, to: :published
    end

  end
end