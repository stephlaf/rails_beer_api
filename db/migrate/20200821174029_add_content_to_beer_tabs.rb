class AddContentToBeerTabs < ActiveRecord::Migration[6.0]
  def change
    add_column :beer_tabs, :content, :string
  end
end
