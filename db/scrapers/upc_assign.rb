require 'csv'

def upc_assign
  filepath = File.join(__dir__, 'upcs.csv')
  csv_options = csv_options = { col_sep: ',', headers: :first_row, header_converters: :symbol }

  CSV.foreach(filepath, csv_options) do |row|
    row[:beer_name]
    beer = Beer.find_by(name: row[:beer_name])
    
    if beer
      beer.brewery.name = row[:brewery_name]
      beer.upc = row[:upc]
      beer.save!
    end
  end
end
