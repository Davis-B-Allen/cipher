class Sign < ActiveRecord::Base
  include Geokit
  belongs_to :location, :foreign_key => "status_order", :primary_key => "status_order"
  
  NORTH_HEADING = 30.0
  EAST_HEADING = 120.0
  SOUTH_HEADING = 210.0
  WEST_HEADING = 300.0

  def update_ll
    # gf = self.location.gf
    # gt = self.location.gt
    gf = LatLng.new(self.location.from_lat, self.location.from_lon)
    gt = LatLng.new(self.location.to_lat, self.location.to_lon)
    # gf = Location.find(1332).gf
    # gt = Location.find(1332).gt
    
    h = gf.heading_to(gt)
    puts "heading is #{h}"
    puts "cardinal_side is #{self.location.cardinal_side}"

    #  To determine if clockwise or ccw, Set 360 degree cardinal direction constants for the grid. Compare this heading, h, to the constants to see which it is closest to. If sign.location.cardinal_side is E or W, compare heading, h, to N or S. If sign.location.cardinal_side is N or S, compare to E or W. Write case statement to handle N or S for E or W

    case self.location.cardinal_side
    when 'N'
      a = [(self.location.heading - EAST_HEADING).abs, (self.location.heading - WEST_HEADING).abs]
      case a.index(a.min)
      when 0
        offset_h = (h-90).modulo(360)
      when 1
        offset_h = (h+90).modulo(360)
      end
    when 'S'
      a = [(self.location.heading - EAST_HEADING).abs, (self.location.heading - WEST_HEADING).abs]
      case a.index(a.min)
      when 0
        offset_h = (h+90).modulo(360)
      when 1
        offset_h = (h-90).modulo(360)
      end
    when 'E'
      a = [(self.location.heading - NORTH_HEADING).abs, (self.location.heading - SOUTH_HEADING).abs]
      case a.index(a.min)
      when 0
        offset_h = (h+90).modulo(360)
      when 1
        offset_h = (h-90).modulo(360)
      end
    when 'W'
      a = [(self.location.heading - NORTH_HEADING).abs, (self.location.heading - SOUTH_HEADING).abs]
      case a.index(a.min)
      when 0
        offset_h = (h-90).modulo(360)
      when 1
        offset_h = (h+90).modulo(360)
      end
    end
    
    # if clockwise from heading
    # offset_h = (h+90).modulo(360)

    # if ccw from heading
    # offset_h = (h-90).modulo(360)
    
    puts "offset heading is #{offset_h}"

    lat_lng = gf.endpoint(h, self.curb_distance.to_f/5280)
    lat_lng = lat_lng.endpoint(offset_h, 0.005)
    puts lat_lng.ll.split(',')[0].to_f
    puts lat_lng.ll.split(',')[1].to_f
    self.lat = lat_lng.ll.split(',')[0].to_f
    self.lng = lat_lng.ll.split(',')[1].to_f
    self.save
  end

end
