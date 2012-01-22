class GeolocationController < ApplicationController
  include HTTParty

  def fetch_block
    # lat = params[:lat]
    # lon = params[:lon]
    lat = 40.7603225
    lon = -73.97918829
    
    htintr = HTTParty.get("http://api.geonames.org/findNearestIntersection?lat=#{lat}&lng=#{lon}&username=davisallen")
    puts "#{Time.now}"
    htstr = HTTParty.get("http://api.geonames.org/findNearestAddress?lat=#{lat}&lng=#{lon}&username=davisallen")
    puts "#{Time.now}"

    street1 = htintr.parsed_response["geonames"]["intersection"]["street1"]
    street2 = htintr.parsed_response["geonames"]["intersection"]["street2"]
    main_street = htstr.parsed_response["geonames"]["address"]["street"]
    other_street = [street1, street2].delete_if { |x| x == main_street }[0]
    
    puts "#{street1} and #{street2} and #{main_street}"
    
    
    main_street.gsub!(/^W\s/, "WEST ")
    main_street.gsub!(/^E\s/, "EAST ")
    main_street.gsub!(/^N\s/, "NORTH ")
    main_street.gsub!(/^S\s/, "SOUTH ")
    
    main_street.gsub!(/\s[0-9]+[a-z|A-Z]+/) { |m| " " + m.to_i.to_s }
    
    main_street.gsub!(/\sSt$/, " STREET")
    
    main_street.gsub!(/\sAve$/, " AVENUE")
    
    main_street.gsub!(/\sPlz$/, " PLAZA")
    
    puts "#{street1 == main_street}"
    puts "#{street2 == main_street}"
    
    puts other_street
    other_street.gsub!(/^W\s/, "WEST ")
    other_street.gsub!(/^E\s/, "EAST ")
    other_street.gsub!(/^N\s/, "NORTH ")
    other_street.gsub!(/^S\s/, "SOUTH ")

    other_street.gsub!(/\s[0-9]+[a-z|A-Z]+/) { |m| " " + m.to_i.to_s }
    
    other_street.gsub!(/\sSt$/, " STREET")
    
    other_street.gsub!(/\sAve$/, " AVENUE")
    
    other_street.gsub!(/\sPlz$/, " PLAZA")

    puts other_street
    
    

    # raise exception if [street1, street2].include?(main_street)
    
    # Find all locations by main street = main street, to_street = other_street
    locations = Location.where("UPPER(main_street) LIKE '%#{main_street.upcase}%' AND UPPER(to_street) LIKE '%#{other_street.upcase}%'")
    # locations = Location.where("UPPER(main_street) LIKE '%#{main_street.upcase}%' AND UPPER(from_street) LIKE '%#{other_street.upcase}%'")
    puts locations.to_json
    # Find all locations by main street = main street, from_street = other_street
    # Location.where('main_street LIKE "#{main_street}" AND from_street LIKE "#{other_street}"')
    
    # for each in location array
    signs_array = []
    locations.each do |l|
      signs = Sign.find_all_by_status_order(l.status_order)
      signs.each do |s|
        sh = s.attributes
        sh["from_street"] = l.from_street
        signs_array.push(sh)
      end
    end
    
    render :json => signs_array
    
    # find sign by status order
    
  end

  def sign_lat_lons
    signs = Location.demoables.map{ |l| l.signs }
    signs.flatten!
    i=1
    signs.map! do |s|
      i = i + 1
      if(i % 2 == 0) 
        { "la" => s.lat, "lo" => s.lng, "color" => "red" }
      else
        { "la" => s.lat, "lo" => s.lng, "color" => "green" }
      end  
      
    end
    render :json => signs
  end

end
