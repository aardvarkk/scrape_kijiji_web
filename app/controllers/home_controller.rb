require 'net/http'

class HomeController < ApplicationController

	QUERY_URI = 'http://guelph.kijiji.ca/f-SearchAdRss?AdType=2&CatId=36&Location=1700242'

  def index
  	@listings = Hash.from_xml(Net::HTTP.get(URI(QUERY_URI)))
  end

end
