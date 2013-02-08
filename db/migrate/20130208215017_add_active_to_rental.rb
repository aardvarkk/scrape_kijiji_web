class AddActiveToRental < ActiveRecord::Migration
  def change
    add_column :rentals, :active, :boolean, :default => true, :null => false
  end
end
