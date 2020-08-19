require 'open-uri'
require 'nokogiri'
require 'csv'

# ______________________________________
# USERS

puts "Destroying all users"
User.destroy_all

puts "Creating users..."

names = %w[a b c d e]
user_counter = 0

5.times do
  User.create!(email: "#{names[user_counter]}@#{names[user_counter]}.#{names[user_counter]}", password: '123456')
  user_counter += 1
end

# ________________________________________
# BREWERIES

puts "Destroying all breweries..."
Brewery.destroy_all

# Gettings names from CSV
csv_options = { col_sep: ',', headers: :first_row, header_converters: :symbol }

filepath = File.join(__dir__, 'amq.csv')

amq_names = []
CSV.foreach(filepath, csv_options) do |row|
  amq_names << row[:name].titleize.gsub(/\s{2,}/, ' ').gsub("L'", "l'").gsub('à', 'À')
end

clean_amq_names = amq_names.uniq

puts "Creating breweries from AMQ list..."

clean_amq_names.each do |name|
  Brewery.create!(name: name)
end

# pp Brewery.all


# ________________________________________
# BEERS Dieu du Ciel!

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
upcs = %w[4902125189003 0011391001897 0011391001835 14214267-000499 0060383857974 7630054475702 7630054474606]

brewery = Brewery.find_by(name: 'Dieu Du Ciel!')

beers = links.first(7).map do |link|
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

  beer.brewery = brewery

  beer.save!

  p counter += 1
end

# pp Beer.all
# SKU 1339107 Genese
