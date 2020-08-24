# require 'open-uri'
# require 'nokogiri'
# require 'csv'

# require_relative './scrapers/scrape_brasseurs_du_monde'
# require_relative './scrapers/scrape_dieu_du_ciel'
# require_relative './scrapers/scrape_farnham'
# require_relative './scrapers/scrape_trefle_noir'
# require_relative './scrapers/scrape_hermite'
# require_relative './scrapers/upc_assign'

# # ______________________________________
# # BEER TABS
# puts "Destroying all beer tabs..."
# BeerTab.destroy_all

# # ______________________________________
# # USERS

# puts "Destroying all users..."
# User.destroy_all

# puts "Creating users..."

# names = %w[a b c d e]
# user_counter = 0

# 5.times do
#   User.create!(email: "#{names[user_counter]}@#{names[user_counter]}.#{names[user_counter]}", password: '123456')
#   user_counter += 1
# end

# # ________________________________________
# # BREWERIES

# puts "Destroying all breweries..."
# Brewery.destroy_all

# # Gettings names from CSV
# filepath = File.join(__dir__, 'amq.csv')
# csv_options = { col_sep: ',', headers: :first_row, header_converters: :symbol }

# amq_names = []

# CSV.foreach(filepath, csv_options) do |row|
#   amq_names << row[:name].titleize.gsub(/\s{2,}/, ' ').gsub('à', 'À')#.gsub("L'", "l'")
# end

# clean_amq_names = amq_names.uniq

# puts "Creating breweries from AMQ list..."

# clean_amq_names.each do |name|
#   Brewery.create!(name: name)
# end

# # pp Brewery.all

# # ________________________________________
# # BEERS

# puts "Destroying all beers..."
# Beer.destroy_all

# # ____________________________________________________
# # BEERS Brasseurs du Monde

# scrape_brasseurs_du_monde
# puts "Done Brasseurs du Monde 🍻"

# # ________________________________________
# # BEERS Dieu du Ciel!

# scrape_dieu_du_ciel
# puts "Done Dieu du Ciel! 🍻"

# # ____________________________________________________
# # BEERS Farnham

# scrape_farnham
# load_csv
# puts "Done Farnham 🍻"

# # ____________________________________________________
# # BEERS Trefle Noir

# scrape_trefle_noir
# puts "Done Trefle Noir 🍻"

# # ____________________________________________________
# # BEERS Hermite

# scrape_hermite
# puts "Done Hermite 🍻"

# # ___________________________________________________
# # UPCs assign
# puts "Assigning UPCs..."
# upc_assign

# # ____________________________________________________
# # UPCs Randomize

# # counter = 0
# # upcs = %w[4902125189003 0011391001897 0011391001835 14214267-000499 0060383857974 7630054475702 7630054474606]
# # beers = Beer.all

# # upcs.count.times do
# #   random_beer = beers.sample
# #   random_beer.upc = upcs[counter]
# #   random_beer.save!

# #   counter += 1
# # end

# puts "All done 😃"

require 'csv'

filepath = File.join(__dir__, 'amq.csv')
csv_options = { col_sep: ',', headers: :first_row, header_converters: :symbol }

accents = %w[à è é]
amq_names = []

CSV.foreach(filepath, csv_options) do |row|
  cleaned = row[:name].gsub(/\s{2,}/, ' ').gsub(/\s-\s/, ' ').gsub(/[[:space]]/, '')#.gsub("L'", "l'")
  titled = []
  
  cleaned.titleize.split.each_with_index do |str, index|
    if index.zero? && (str == 'à' || str == 'la' || str == 'le' || str == 'ô')
      titled << str.upcase
    elsif index.positive? && (str == 'À' || str == 'La' || str == 'Le' || str == 'De' || str == 'Les' || str == 'Du' || str == 'Sur') || str == 'Et'
      titled << str.downcase
    elsif str.start_with?("L'")
      splitted = str.split("'")
      first = splitted.first.downcase
      last = splitted.last.capitalize
      titled << "#{first}'#{last}"
    else
      titled << str
    end
  end

  # titled.gsub('à', 'À') if titled.start_with?('à')
  pp titled.join(' ')
end
