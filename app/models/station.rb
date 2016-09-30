class Station < ApplicationRecord


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

  def get_distance_info(other_station)
    get_distance_matrix(location, other_station.location)
  end
end
