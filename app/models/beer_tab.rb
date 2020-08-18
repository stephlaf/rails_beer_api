class BeerTab < ApplicationRecord
  belongs_to :user
  belongs_to :beer
end
