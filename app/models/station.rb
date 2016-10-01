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
    Station.find_each do |station|
      update_destination(other_station)
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
