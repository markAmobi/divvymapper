class Station < ApplicationRecord
  has_many :destinations, as: :origin

  def self.get_live_feed
    get_divvy_data
  end


  ## group is a hash where origins point to origins id, destinations point to detinations id. must be 24 or less. thanks to API limits.
  ## (assume single origin, possibly multiple destinations.)
  def self.update_chunk(group)
    # raise "Cannot be more than 25 items " if group.values.flatten.count > 25
    # based on preliminary test, it seems like 1 origin to 100 destination works contrary to what I understood from the
    # distance matrix API limits documentation. https://developers.google.com/maps/documentation/distance-matrix/usage-limits
    start_stations = Station.find(group["origins"])
    end_stations = Station.find(group["destinations"])

    start_locations = start_stations.map(&:geo_coords)
    end_locations = end_stations.map(&:geo_coords)

    response = get_distance_duration(start_locations, end_locations)
    parsed_response = translate_response(start_locations, end_locations, response)

    parsed_response.each do |o_coords, o_details|
      start_station = Station.where(geo_coords: "{#{o_coords.join(',')}}").first
      o_details["destinations"].each do |d_coords, d_details|
        other_details = {"geo_coords" => d_coords, "origin_address" => o_details["origin_address"] }

        d = d_details.merge(other_details)

        destination = Destination.new(d)
        destination.origin = start_station
        destination.save!
      end
    end

    ## still have access to ids, so distances shouldn't be mixed up.
    ## might need to save the address gotten back from Google maps even though it may not be precise. we
    ## can just use for estimate reference.

  end

  def self.update_stations
    self.destroy_all
    stations = self.get_live_feed
    stations.each do |station|
      s = station
      s["geo_coords"] = [station["latitude"], station["longitude"]]
      self.create(s)
    end
  end


  #
  # def update_destination(other_station)
  #   dest_info = self.get_distance_info(other_station)
  #   d = Destination.new
  #   d.assign_attributes(dest_info)
  #   d.origin = self
  #   d.save!
  # end

  ##for updating individual stations destinations.
  # def update_destinations
    ## see https://developers.google.com/maps/documentation/distance-matrix/usage-limits
    ## really need a way send multiple requests while still within API rate limits.
    ## right now, I'm doing 1pair of origin/destination per request.
    ## need 580 * 580 = 336400 based on my current setup.
    ## can cut this in half by adding some logic not to redo pairs that have been done.
    ## this is still a lot. 168200.
    ## even if I get 25 destination per request, that still leaves me with 6728 requests.
    ## but I have 2500 per day. I should be able to set this up so I just get all the data I need
    ## in three days. and probably store in csv or something so I don't have to get it again.
    ## before going ahead to implement this, I should probably think about interaction with the directions
    ## API and see if it's independent. if not, then i have to do that at same time in order to have data to
    ## to display directions info on the map.
    ## need to look into encoded polyline, maybe? or just put multiple destinations in request.
    # raise "DONT DO THIS!!!! Google API limits has limits. "
    # Station.find_each do |station|
    #   update_destination(station)
    # end
  # end

  ## this method will be used to update the destinations among all stations.
  # def self.update_all_destinations
  #
  #   ## due to ap usage limits, this method might use different keys if run once.
  #
  #   Station.find_each do |station|
  #     station.update_destinations
  #   end
  # end

  # def get_distance_info(other_station)
  #   parse_distance_matrix(get_distance_matrix(location, other_station.location))
  # end
end
