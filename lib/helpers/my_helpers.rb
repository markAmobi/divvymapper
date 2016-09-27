def do_stuff
  puts "HELLO, there"
end

# start and end are hashes with lat, lng.
def get_distance_matrix(start_point, end_point)
  request_url = ""
  points = [start_point, end_point].map{|p| p.values.join(",")}.join("|")

  data = HTTP.get(request_url).parse

end
