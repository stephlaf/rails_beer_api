class CreateBeers < ActiveRecord::Migration[6.0]
  def change
    create_table :beers do |t|
      t.string :image_link
      t.string :name
      t.string :alc_percent
      t.string :short_desc
      t.string :long_desc
      t.timestamps
    end
  end
end
