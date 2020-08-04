class Beer
  def initialize(att = {})
    @image_link = att[:image_link]
    @name = att[:name]
    @alc_percent = att[:alc_percent]
    @short_desc = att[:short_desc]
    @long_desc = att[:long_desc]
  end
end
