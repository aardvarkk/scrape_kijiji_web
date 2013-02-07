class HomeController < ApplicationController

  def index
  	@listings = Rental.order("pubdate DESC").all
  	@newest = @listings.first(10)

  	respond_to do |format|
      format.html
      format.js { render :js => @listings.to_json }
    end
  end

  def map
  end

end
