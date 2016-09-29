# require 'helpers/my_helpers'
desc "gets current station info from divvy and puts in my database"

task :update_stations => :environment do
  Station.update_stations
end

task :test_helper => :environment do
  # do_stuff
  #ap ENV['GOOGLE_MAPS_API_KEY']
end

task :tt => :environment do
  get_distance_matrix({latitude: 41.8725614, longitude: -87.6245382}, {latitude: 41.86722595682,longitude: -87.6153553902})
end
