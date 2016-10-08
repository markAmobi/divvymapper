def do_stuff
  puts "HELLO, there"
end

## start_locations = [[lat,lng]].
## not that this returns info for all start end combination given.
## returns distance duration info.
def get_distance_duration(start_locations, end_locations)
  origins = start_locations.map{ |l| l.map(&:to_s).join(",") }.join("|")
  destinations = end_locations.map{ |l| l.map(&:to_s).join(",") }.join("|")

  request_url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins="+
  "#{origins}&destinations=#{destinations}&mode=bicycling&key=#{ENV['GOOGLE_MAPS_API_KEY_TEST']}"

  response = HTTP.get(request_url).parse
end

## transform google API response to what I feel will be easier for me to handle.
## this method is to be used to parse the response from get_distance_duration above.
## it translates the response to a format thats easier for me to store things in my
## destinations table.
## TODO: take care of cases with zero results or not okay status.
def translate_response(start_locations, end_locations, response)
  final_output = {}
  o_addresses = response["origin_addresses"]
  d_addresses = response["destination_addresses"]
  rows = response["rows"]

  start_locations.each_with_index do |location, o_index|

    dest_hash = {"origin_address" => o_addresses[o_index], "destinations" => {} }

    rows[o_index]["elements"].each_with_index do |destination_details, d_index|
      d = {}
      d["distance"] = destination_details["distance"]["value"]
      d["distance_text"] = destination_details["distance"]["text"]
      d["duration"] = destination_details["duration"]["value"]
      d["duration_text"] = destination_details["duration"]["text"]
      d["address"] = d_addresses[d_index]

      dest_hash["destinations"][end_locations[d_index]] = d
    end

    final_output[location] = dest_hash
  end

  final_output
end

def get_divvy_data
  data = HTTP.get("https://feeds.divvybikes.com/stations/stations.json").parse["stationBeanList"]
  ## convert camel case to snake case.
  stations = data.map do |s|
    s.map{|k,v| [k.underscore,v]}.to_h
  end
end
