class Station < ApplicationRecord
  has_many :destinations, as: :origin

  def self.get_live_feed
    get_divvy_data
  end


  ## this is used to update destinations between origin and destination stations based on id.
  ## group is a hash where origins point to origins id, destinations point to detinations id. must be 24 or less. thanks to API limits.
  ## (assume single origin, possibly multiple destinations.)
  def self.update_mutiple_stations(group)
    # raise "Cannot be more than 25 items " if group.values.flatten.count > 25
    # based on preliminary test, it seems like 1 origin to 100 destination works contrary to what I understood from the
    # distance matrix API limits documentation. https://developers.google.com/maps/documentation/distance-matrix/usage-limits
    start_stations = Station.find(group["origins"])
    end_stations = Station.find(group["destinations"])

    start_locations = start_stations.map(&:geo_coords)
    end_locations = end_stations.map(&:geo_coords)

    response = get_distance_duration(start_locations, end_locations)
    parsed_response = translate_response(start_locations, end_locations, response)

    self.update_station_details(parsed_response)
  end


  ## use result of parsed_response to update stations destinations to database.
  def self.update_station_details(parsed_response)
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

end
