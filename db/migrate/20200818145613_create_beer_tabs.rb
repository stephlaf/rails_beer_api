class CreateBeerTabs < ActiveRecord::Migration[6.0]
  def change
    create_table :beer_tabs do |t|
      t.boolean :tried, default: false
      t.float :rating

      t.timestamps
    end
  end
end
