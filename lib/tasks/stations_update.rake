# require 'helpers/my_helpers'
desc "gets current station info from divvy and puts in my database"

task :update_stations => :environment do
  Station.update_stations
end

task :test_helper => :environment do
  do_stuff
end
