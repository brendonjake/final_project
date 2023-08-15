class Item < ApplicationRecord
  default_scope { where(deleted_at: nil) }

  validates :name, presence: true
  validates :quantity, presence: true

  enum status: { active: 0, inactive: 1 }

  mount_uploader :image, ImageUploader

  def destroy
    update(deleted_at: Time.now)
  end
end