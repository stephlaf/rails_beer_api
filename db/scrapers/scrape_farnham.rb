require 'open-uri'
require 'nokogiri'
# require_relative 'beer'

def scrape_farnham
  url = "https://farnham-alelager.com/"
  html = open(url).read
  doc = Nokogiri::HTML(html)
  
  brewery = Brewery.find_or_initialize_by(name: 'Farnham')
  brewery.save!

  counter = 1

  8.times do
    doc.search("#sample_slider_slide0#{counter}").map do |element|
      name = element.search('h3').text.strip.titleize

      short_desc = element.search('p strong').text.strip
      dirty_long_desc = element.search('p').text.strip
      
      image_link = element.children.children.attribute('src').value
      photo_file = URI.open(image_link)

      att = {
        image_link: image_link,
        name: name,
        short_desc: short_desc,
        long_desc: dirty_long_desc.gsub(short_desc, ''),
        category: name.split('|').last.strip,
        ibu: name.split('|').first.strip
      }

      beer = Beer.new(att)
      beer.photo.attach(io: photo_file, filename: "#{name}", content_type: 'image/jpg')

      beer.brewery = brewery

      beer.save!

      counter += 1
    end
  end
end

# pp test


# beers = links.map do |link|
#   html = open(link).read
#   doc = Nokogiri::HTML(html)
  
#   att = {}
#   image_link = doc.search('img').attribute('src').value
#   name = doc.search('.h2-inner').text.strip
  
#   open("beer_images/#{name}.png", 'w') { |file| file << open(image_link).read }

#   att[:image_link] = image_link
#   att[:name] = name
#   att[:alc_percent] = doc.search('.abv').text.strip
#   att[:short_desc] = doc.search('.short-desc p').text.strip
#   att[:long_desc] = doc.search('.long-desc-inner p').text.strip
  
#   Beer.new(att)
# end

# SKU 1339107 Genese
