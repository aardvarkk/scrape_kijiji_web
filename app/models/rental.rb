class Rental < ActiveRecord::Base
  attr_accessible :description, :link, :price, :pubdate, :title

	QUERY_URI = 'http://guelph.kijiji.ca/f-SearchAdRss?AdType=2&CatId=36&Location=1700242'

  def self.update_all
		rentals = Hash.from_xml(Net::HTTP.get(URI(QUERY_URI)))
		rentals['rss']['channel']['item'].each do |r|
			rtl = Rental.find_or_create_by_link(r['link'])
			rtl.description = r['description']
		  rtl.price = r['title'].partition('$')[2]
		  rtl.pubdate = r['date']
		  rtl.title = r['title']
		  rtl.save
		end
  end

end
