class CreatePacklists < ActiveRecord::Migration
  def change
    create_table :packlists do |t|
      t.string :where
      t.integer :how_long
      t.string :weather
      t.text :activities

      t.timestamps
    end
  end
end
