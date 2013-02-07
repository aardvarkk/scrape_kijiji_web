require 'net/http'

class HomeController < ApplicationController

  def index
  	Rental.update_all
  	@rentals = Rental.all
  end

end
