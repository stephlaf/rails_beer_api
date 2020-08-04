class AddUpcToBeers < ActiveRecord::Migration[6.0]
  def change
    add_column :beers, :upc, :string
  end
end
