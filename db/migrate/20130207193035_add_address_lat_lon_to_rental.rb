class AddAddressLatLonToRental < ActiveRecord::Migration
  def change
    add_column :rentals, :address, :text
    add_column :rentals, :lat, :decimal
    add_column :rentals, :lon, :decimal
  end
end
