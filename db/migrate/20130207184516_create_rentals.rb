class CreateRentals < ActiveRecord::Migration
  def change
    create_table :rentals do |t|
      t.text :title
      t.text :link
      t.text :description
      t.datetime :pubdate
      t.decimal :price

      t.timestamps
    end
  end
end
