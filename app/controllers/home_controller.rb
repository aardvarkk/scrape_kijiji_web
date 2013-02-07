class HomeController < ApplicationController

  def index
  	@rentals = Rental.order("pubdate DESC").all
  end

end
