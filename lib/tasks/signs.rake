namespace :signs do
  require 'csv'

  desc "import signs from csv"

  task :import_sign_csv_data => :environment do
    CSV.foreach("msigns.csv") do |row|
      Sign.create(:borough_code => row[0], :status_order => row[1], :sign_sequence => row[2], :curb_distance => row[3], :arrow_cardinal => row[4], :description => row[5])
    end
    
  end

  desc "Remove blank string arrow cardinal entries"

  task :remove_blank_arrow_cardinals => :environment do
    Sign.all.each do |s|
      s.update_attribute(:arrow_cardinal, nil) if s.arrow_cardinal.blank?
    end
  end

end
