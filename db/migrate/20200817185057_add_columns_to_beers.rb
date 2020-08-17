class AddColumnsToBeers < ActiveRecord::Migration[6.0]
  def change
    add_column :beers, :category, :string
    add_column :beers, :rating, :float
    add_reference :beers, :brewery, null: false, foreign_key: true
  end
end
