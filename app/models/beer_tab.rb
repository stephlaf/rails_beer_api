class BeerTab < ApplicationRecord
  belongs_to :user
  belongs_to :beer

  validates :rating, presence: true

  scope :first_user_beer_tabs, -> { where(user: User.first) }
end
