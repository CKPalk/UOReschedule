require 'csv'

desc "Imports a CSV file into an ActiveRecord table"
task :import, [:filename] => :environment do
	CSV.foreach( 'courses_data.csv', :headers => true ) do |row|
		Course.create!( row.to_hash )
	end
end
