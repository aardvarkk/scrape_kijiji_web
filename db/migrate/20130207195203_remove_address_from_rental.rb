class RemoveAddressFromRental < ActiveRecord::Migration
  def change
    remove_column :rentals, :address
  end
end
