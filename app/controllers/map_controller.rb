class MapController < ApplicationController

  def map
    @stations = Station.all
  end

  def station
    @station = Station.find(params[:station_id])
  end

  def nearest_stations
    
  end

end
