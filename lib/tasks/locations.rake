namespace :locations do
  require 'csv'

  desc "import locations from csv"

  task :import_location_csv_data => :environment do    
    CSV.foreach("mlocations.csv") do |row|
      Location.create(:borough_code => row[0], :status_order => row[1], :main_street => row[2], :from_street => row[3], :to_street => row[4], :cardinal_side => row[5])
    end
    
  end
  
  
  desc "taking out spaces" 
  task :takes_out_spaces => :environment do
    Location.all.each do |l|
      l.main_street = l.main_street.squeeze(" ")
      l.from_street = l.from_street.squeeze(" ")
      l.to_street = l.to_street.squeeze(" ")

      
      l.save!
      
    end
  end

  desc "fix sixth avenues" 
  task :fix_sixth_avenues => :environment do
    Location.all.each do |l|
      l.main_street = "6 AVENUE" if l.main_street == "AVENUE OF THE AMERICAS"
      l.main_street = "6 AVENUE" if l.main_street == "AVENUE OF AMERICAS"
      
      l.to_street = "6 AVENUE" if l.to_street == "AVENUE OF THE AMERICAS"
      l.to_street = "6 AVENUE" if l.to_street == "AVENUE OF AMERICAS"
      
      l.from_street = "6 AVENUE" if l.from_street == "AVENUE OF THE AMERICAS"
      l.from_street = "6 AVENUE" if l.from_street == "AVENUE OF AMERICAS"
      
      l.save!
      
    end
  end

  desc "print streets and cross streets" 
  task :print_streets => :environment do
    idarray = [1392, 1393, 1394, 1395, 3184, 6526, 1381, 1423, 753, 1222, 1338, 1389, 3102, 11530, 1209, 1360, 1332, 1347, 6799, 4527, 11485, 1329, 11529, 1333, 10634, 1334, 9289, 1330, 10513, 1337, 1350, 9291, 11527, 7715, 3978, 10135, 2549, 11526, 9302, 1345, 11155, 11491, 11525, 10898, 1348, 1427, 11489, 11524, 11492, 1107, 10136, 11486, 11523, 11494]
    
    idarray.each do |id|
      l = Location.find(id)
      puts "#{l.id} #{l.heading}"
    end
  end

  desc "tag demoable blocks" 
  task :tag_demoable_blocks => :environment do
    idarray = [1392, 1393, 1394, 1395, 3184, 6526, 1381, 1423, 753, 1222, 1338, 1389, 3102, 11530, 1209, 1360, 1332, 1347, 6799, 4527, 11485, 1329, 11529, 1333, 10634, 1334, 9289, 1330, 10513, 1337, 1350, 9291, 11527, 7715, 3978, 10135, 2549, 11526, 9302, 1345, 11155, 11491, 11525, 10898, 1348, 1427, 11489, 11524, 11492, 1107, 10136, 11486, 11523, 11494]
    
    idarray.each do |id|
      l = Location.find(id)
      l.demo = true
      l.save
    end
  end

  desc "save lat / lon data for demoable blocks" 
  task :lat_lon_demoable_blocks => :environment do
    # locations = Location.where("demo = 't'")
    # idarray = [1392, 1393, 1394, 1395, 3184, 6526]
    # idarray = [1381, 1423, 753, 1222, 1338, 1389]
    # idarray = [3102, 11530, 1209, 1360, 1332, 1347]
    # idarray = [6799, 4527, 11485, 1329, 11529, 1333]
    # idarray = [10634, 1334, 9289, 1330, 10513, 1337]
    # idarray = [1350, 9291, 11527, 7715, 3978, 10135]
    # idarray = [2549, 11526, 9302, 1345, 11155, 11491]
    # idarray = [11525, 10898, 1348, 1427, 11489, 11524]
    idarray = [11492, 1107, 10136, 11486, 11523, 11494]
    
    idarray.each do |id|
      l = Location.find(id)
      l.update_lllh
      # l.signs.each do |s|
      #   sign.update_ll
      # end
    end
  end

  desc "save lat / lon data for demoable blocks children signs" 
  task :lat_lon_demoable_signs => :environment do
    locations = Location.where("demo = 't'")
    
    locations.each do |l|
      l.signs.each do |s|
        s.update_ll
      end
    end
  end

end
