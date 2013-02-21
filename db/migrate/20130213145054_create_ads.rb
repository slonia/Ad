class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :title
      t.text :description
      t.string :city
      t.decimal :price
      t.integer :section_id

      t.timestamps
    end
  end
end
