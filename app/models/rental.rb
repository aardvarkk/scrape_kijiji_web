require 'net/http'
require 'nokogiri'
require 'open-uri'
require 'money'

class Rental < ActiveRecord::Base

  attr_accessible :description, :link, :price, :pubdate, :title, :address, :lat, :lon, :active

  # Have a default scope so that we only look at active properties
  default_scope where(:active => true)

  QUERY_BASE = 'http://guelph.kijiji.ca'
	QUERY_URI = QUERY_BASE + '/f-SearchAdRss?AdType=2&CatId=36&Location=1700242'
	VIEWMAP_URI = QUERY_BASE + '/c-ViewMap?AdId='

	GEOCODE_URI = 'http://maps.googleapis.com/maps/api/geocode/xml?address='
	GEOCODE_SUFF = '&sensor=false&region=ca'

	def self.get_latlon(link)
		page = Nokogiri::HTML(open(VIEWMAP_URI + link.partition('AdIdZ')[2]))
		loc = {
		 :lat => page.xpath("//meta[@property='og:latitude']/@content"), 
		 :lon => page.xpath("//meta[@property='og:longitude']/@content")
		}
	end

  def self.update_all
		rentals = Hash.from_xml(Net::HTTP.get(URI(QUERY_URI)))
		rentals['rss']['channel']['item'].each do |r|
			
			# Basics
			rtl = Rental.unscoped.find_or_create_by_link(r['link'])
			rtl.description = r['description']
		  rtl.pubdate = r['date']
		  rtl.title = r['title']

		  # Get price -- we check that there is a valid separator (index 1)
		  # And if so, take the second part (the actual dollar value)
		  price_part = r['title'].rpartition('$')
		  rtl.price = price_part[1].present? ? Money.parse(price_part[2]) : nil
		  
		  # Geocoding stuff
		  loc = get_latlon(r['link'])
		  rtl.lat = loc[:lat]
		  rtl.lon = loc[:lon]

		  # Done
		  rtl.save
		  rtl.touch # Updates "updated_at"

		  puts "Updated #{rtl.link}"
		end
  end

end
