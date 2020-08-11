require 'open-uri'
require 'nokogiri'

url = "https://dieuduciel.com/categories/en-bouteille/"
html = open(url).read
doc = Nokogiri::HTML(html)

puts "Destroying all beers..."
Beer.destroy_all

puts "Getting links..."

links = doc.search('.product-item').map do |element|
  element.attribute('data-href').value
end

puts "Creating beers..."

counter = 0
upcs = %w[4902125189003 0011391001897 0011391001835 14214267-000499 0060383857974]

beers = links.first(5).map do |link|
  html = open(link).read
  doc = Nokogiri::HTML(html)
  
  att = {}
  image_link = doc.search('img').attribute('src').value
  name = doc.search('.h2-inner').text.strip
  
  photo_file = URI.open(image_link)
  
  # open("beer_images/#{name}.png", 'w') { |file| file << open(image_link).read }

  att[:image_link] = image_link
  att[:name] = name
  att[:alc_percent] = doc.search('.abv').text.strip
  att[:short_desc] = doc.search('.short-desc p').text.strip
  att[:long_desc] = doc.search('.long-desc-inner p').text.strip
  att[:upc] = upcs[counter]
  
  beer = Beer.new(att)
  beer.photo.attach(io: photo_file, filename: "#{name}", content_type: 'image/jpg')
  beer.save!

  p counter += 1
end

pp Beer.all
# SKU 1339107 Genese
