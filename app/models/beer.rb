class Beer < ActiveRecord::Base
  # def initialize(att = {})
  #   @image_link = att[:image_link]
  #   @name = att[:name]
  #   @alc_percent = att[:alc_percent]
  #   @short_desc = att[:short_desc]
  #   @long_desc = att[:long_desc]
  # end
  has_many :beer_tabs, dependent: :destroy
  belongs_to :brewery
  
  has_one_attached :photo

  scope :order_by_name, -> { order(name: :asc) }
end
