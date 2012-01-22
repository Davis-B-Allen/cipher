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

end
