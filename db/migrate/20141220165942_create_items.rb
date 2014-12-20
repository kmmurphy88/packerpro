class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :article
      t.integer :quantity

      t.belongs_to :packlist, index: true

      t.timestamps
    end
  end
end
