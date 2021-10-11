class TempBeer < ApplicationRecord
  has_one_attached :sent_photo
  has_one_attached :sent_upc_photo

  has_one_attached :photo
  has_one_attached :upc_photo

  validates :name, :brewery_name, :photo, :upc_photo, presence: true
end
