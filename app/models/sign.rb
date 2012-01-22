class Sign < ActiveRecord::Base

  def update_ll
    # gf = self.location.gf
    # gt = self.location.gt
    gf = Location.find(1332).gf
    gt = Location.find(1332).gt
    
    h = gf.heading_to(gt)
    puts "heading is #{h}"

    #  To determine if clockwise or ccw, Set 360 degree cardinal direction constants for the grid. Compare this heading, h, to the constants to see which it is closest to. If sign.location.cardinal_side is E or W, compare heading, h, to N or S. If sign.location.cardinal_side is N or S, compare to E or W. Write case statement to handle N or S for E or W
    # if clockwise from heading
    # offset_h = (h+90).modulo(360)

    # if ccw from heading
    offset_h = (h-90).modulo(360)
    
    puts "offset heading is #{offset_h}"

    lat_lng = gf.endpoint(h, self.curb_distance.to_f/5280)
    puts lat_lng.ll
    lat_lng = lat_lng.endpoint(offset_h, 0.005)
    puts lat_lng.ll
  end

end
