class Station < ApplicationRecord
  has_many :destinations, as: :origin

  def self.get_live_feed
    get_divvy_data
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
