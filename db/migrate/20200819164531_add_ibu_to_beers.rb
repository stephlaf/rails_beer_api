class AddIbuToBeers < ActiveRecord::Migration[6.0]
  def change
    add_column :beers, :ibu, :integer
  end
end
