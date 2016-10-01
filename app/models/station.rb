class Station < ApplicationRecord
  has_many :destinations, as: :origin

  def location
    {latitude: latitude, logitude: longitude}
  end

  def self.get_live_feed
    get_divvy_data
  end

  def self.update_stations
    self.destroy_all
    stations = self.get_live_feed
    stations.each do |station|
      self.create(station)
    end
  end


  def update_destination(other_station)
    dest_info = self.get_distance_info(other_station)
    d = Destination.new
    d.assign_attributes(dest_info)
    d.origin = self
    d.save!
  end

  ##for updating individual stations destinations.
  def update_destinations
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
    raise "DONT DO THIS!!!! Google API limits has limits. "
    Station.find_each do |station|
      update_destination(station)
    end
  end

  ## this method will be used to update the destinations among all stations.
  def self.update_all_destinations
    Station.find_each do |station|
      station.update_destinations
    end
  end

  def get_distance_info(other_station)
    parse_distance_matrix(get_distance_matrix(location, other_station.location))
  end
end
