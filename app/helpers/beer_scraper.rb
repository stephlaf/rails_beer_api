require 'open-uri'
require 'nokogiri'
require_relative 'beer'

url = "https://dieuduciel.com/categories/en-bouteille/"
html = open(url).read
doc = Nokogiri::HTML(html)

links = doc.search('.product-item').map do |element|
  element.attribute('data-href').value
end

beers = links.map do |link|
  html = open(link).read
  doc = Nokogiri::HTML(html)
  
  att = {}
  image_link = doc.search('img').attribute('src').value
  name = doc.search('.h2-inner').text.strip
  
  open("beer_images/#{name}.png", 'w') { |file| file << open(image_link).read }

  att[:image_link] = image_link
  att[:name] = name
  att[:alc_percent] = doc.search('.abv').text.strip
  att[:short_desc] = doc.search('.short-desc p').text.strip
  att[:long_desc] = doc.search('.long-desc-inner p').text.strip
  
  Beer.new(att)
end

# SKU 1339107 Genese
