class RentalsController < ApplicationController

  def index
  	@newest = Rental.order("pubdate DESC").first(10)
    @updated = Rental.maximum(:updated_at)
    @newestpub = Rental.maximum(:pubdate)
  end

  def full
    # Go unscoped so that we get active and inactive
  	@listings = Rental.unscoped.order("pubdate DESC")
    @avg = Rental.average(:price)

    respond_to do |format|
      format.html
      format.js { render :js => Rental.all.to_json }
    end
  end

  def map
  end

  def show
    @listing = Rental.unscoped.find(params[:id])
  end

  def toggle_active
    @listing = Rental.unscoped.find(params[:id])
    @listing.update_attributes(:active => !@listing.active)
    redirect_to rental_path(@listing)
  end

end
