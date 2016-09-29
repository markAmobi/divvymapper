class Station < ApplicationRecord


  def location
    {latitude: latitude, logitude: longitude}
  end

  def self.get_live_feed
    data = HTTP.get("https://feeds.divvybikes.com/stations/stations.json").parse["stationBeanList"]
    ## convert camel case to snake case.
    stations = data.map do |s|
      s.map{|k,v| [k.underscore,v]}.to_h
    end
  end

  def self.update_stations
    self.destroy_all
    stations = self.get_live_feed
    stations.each do |station|
      self.create(station)
    end
  end

  def get_distance_info(other_station)
    origin = {}
  end
end
