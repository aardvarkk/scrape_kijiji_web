class HomeController < ApplicationController

  def index
  	@rentals = Rental.order("pubdate DESC").limit(10).all
  end

  def map
  end

end
