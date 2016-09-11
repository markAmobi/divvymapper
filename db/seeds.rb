# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Station.destroy_all

stations_file = File.read("db/stations.json")
stations = JSON.parse(stations_file)["stationBeanList"]


## this converts the Camel case from json to snake case for consistency in ruby.
stations = stations.map do |s|
  s.map{|k,v| [k.underscore,v]}.to_h
end

stations.each do |station|
  Station.create(station)
end
