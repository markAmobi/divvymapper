def do_stuff
  puts "HELLO, there"
end

# start and end are {latitude: v, longitude: v}
def get_distance_matrix(start_point, end_point)
  #sort is just to ensure lat comes first.
  origin = start_point.sort.to_h.values.map(&:to_s).join(",")
  destination = end_point.sort.to_h.values.map(&:to_s).join(",")

  request_url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{origin}&destinations=#{destination}&mode=bicycling&key=#{ENV['GOOGLE_MAPS_API_KEY']}"
  response = HTTP.get(request_url).parse

  # still need to do stuff with the response.
end

def get_divvy_data
  data = HTTP.get("https://feeds.divvybikes.com/stations/stations.json").parse["stationBeanList"]
  ## convert camel case to snake case.
  stations = data.map do |s|
    s.map{|k,v| [k.underscore,v]}.to_h
  end
end
