class Location < ActiveRecord::Base
  
  def self.googleable_address(street1, street2)
    street1 + " And " + street2 + " New York"
  end

  def update_lll
    from_address = self.class.googleable_address(self.from_street, self.main_street)
    from_geo = Geokit::Geocoders::GoogleGeocoder.geocode from_address
    puts from_geo.ll.split(',')[0].to_f
    puts from_geo.ll.split(',')[1].to_f
    # self.from_lat = from_geo.ll.split(',')[0].to_f
    # self.from_lon = from_geo.ll.split(',')[1].to_f

    to_address = self.class.googleable_address(self.to_street, self.main_street)
    to_geo = Geokit::Geocoders::GoogleGeocoder.geocode to_address
    puts to_geo.ll.split(',')[0].to_f
    puts to_geo.ll.split(',')[1].to_f
    # self.to_lat = to_geo.ll.split(',')[0].to_f
    # self.to_lon = to_geo.ll.split(',')[1].to_f

    length = (from_geo.distance_to(to_geo))*5280
    puts length
    # self.length = length
    
    # self.save
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
