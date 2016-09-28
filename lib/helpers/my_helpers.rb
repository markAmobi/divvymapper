def do_stuff
  puts "HELLO, there"
end

def get_distance_matrix(start_point, end_point)
  #sort is just to ensure lat comes first.
  origin = start_point.sort.to_h.values.map(&:to_s).join(",")
  destination = end_point.sort.to_h.values.map(&:to_s).join(",")

  request_url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{origin}&destinations=#{destination}&mode=bicycling&key=#{ENV['GOOGLE_MAPS_API_KEY']}"

  response = HTTP.get(request_url).parse
  #creat request url
  #sent api request
  #do necessary manipulation
end
