class AddApprovedToBeers < ActiveRecord::Migration[6.0]
  def change
    add_column :beers, :approved, :boolean, default: false
  end
end
