json.counter @counter

json.beer_tabs do
  json.array! @beer_tabs do |beer_tab|
    json.extract! beer_tab,
    :id,
    :content,
    :rating,
    :beer_id,
    :user_id
    :tried
  end
end
