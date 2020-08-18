class AddReferencesToBeerTabs < ActiveRecord::Migration[6.0]
  def change
    add_reference :beer_tabs, :user, foreign_key: true, index: true
    add_reference :beer_tabs, :beer, foreign_key: true, index: true
  end
end
