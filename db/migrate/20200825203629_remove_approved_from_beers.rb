class RemoveApprovedFromBeers < ActiveRecord::Migration[6.0]
  def change
    remove_column :beers, :approved
  end
end
