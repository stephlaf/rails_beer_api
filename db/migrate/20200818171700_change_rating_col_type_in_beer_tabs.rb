class ChangeRatingColTypeInBeerTabs < ActiveRecord::Migration[6.0]
  def change
    change_column :beer_tabs, :rating, :integer
  end
end
