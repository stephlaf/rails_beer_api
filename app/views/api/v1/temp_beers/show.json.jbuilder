json.temp_beer do
  json.extract! @temp_beer, :id,
  :name,
  :brewery_name,
  :upc,
  :converted,
  :photo,
  :upc_photo
end

json.beer do
  json.extract! @beer, :id,
                    :name,
                    :rating,
                    :brewery_id,
                    :ibu,
                    :image_link,
                    :alc_percent,
                    :short_desc,
                    :long_desc,
                    :upc,
                    :category
end
