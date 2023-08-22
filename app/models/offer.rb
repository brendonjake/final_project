class Offer < ApplicationRecord

  enum status: { active: 0, inactive: 1 }
  enum genre: { one_time: 0, monthly: 1, weekly: 2, daily: 3, regular: 4 }


  mount_uploader :image, ImageUploader

end
