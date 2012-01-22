class Location < ActiveRecord::Base
  has_many :signs, :foreign_key => "status_order", :primary_key => "status_order"
  
  scope :demoables,
    where("demo = 't'")

  def self.googleable_address(street1, street2)
    street1 + " And " + street2 + " New York"
  end

  def update_lllh
    puts "************"
    from_address = self.class.googleable_address(self.from_street, self.main_street)
    from_geo = Geokit::Geocoders::GoogleGeocoder.geocode from_address
    puts "lat #{from_geo.ll.split(',')[0].to_f}"
    puts "lon #{from_geo.ll.split(',')[1].to_f}"
    self.from_lat = from_geo.ll.split(',')[0].to_f
    self.from_lon = from_geo.ll.split(',')[1].to_f

    to_address = self.class.googleable_address(self.to_street, self.main_street)
    to_geo = Geokit::Geocoders::GoogleGeocoder.geocode to_address
    puts "lat #{to_geo.ll.split(',')[0].to_f}"
    puts "lon #{to_geo.ll.split(',')[1].to_f}"
    self.to_lat = to_geo.ll.split(',')[0].to_f
    self.to_lon = to_geo.ll.split(',')[1].to_f

    length = (from_geo.distance_to(to_geo))
    puts "length #{length}"
    self.length = length
    
    heading = from_geo.heading_to(to_geo)
    puts "heading #{heading}"
    self.heading = heading
    # 
    self.save
    puts "************"
  end

  def gf
    from_address = self.class.googleable_address(self.from_street, self.main_street)
    from_geo = Geokit::Geocoders::GoogleGeocoder.geocode from_address
    from_geo
  end

  def gt
    to_address = self.class.googleable_address(self.to_street, self.main_street)
    to_geo = Geokit::Geocoders::GoogleGeocoder.geocode to_address
    to_geo
  end

end
