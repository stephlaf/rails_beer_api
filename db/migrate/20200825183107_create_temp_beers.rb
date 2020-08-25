class CreateTempBeers < ActiveRecord::Migration[6.0]
  def change
    create_table :temp_beers do |t|
      t.string :name
      t.string :brewery_name
      t.string :upc
      t.boolean :converted, default: false
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
