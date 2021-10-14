json.array! @temp_beers do |beer|
  json.extract! beer, :id,
                      :name,
                      :brewery_name,
                      :converted,
                      :photo,
                      :upc_photo
end
