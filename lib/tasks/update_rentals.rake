desc "Update rental properties available from Kijiji"
task :update_rentals => :environment do
  Rental.update_all
end