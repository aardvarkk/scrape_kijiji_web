class HomeController < ApplicationController

  def index
  	@newest = Rental.order("pubdate DESC").first(10)
    @updated = Rental.maximum(:updated_at)
  end

  def map
  end

  def full
  	@listings = Rental.order("pubdate DESC").all
    @avg = Rental.average(:price)

    respond_to do |format|
      format.html
      format.js { render :js => @listings.to_json }
    end
  end

end
