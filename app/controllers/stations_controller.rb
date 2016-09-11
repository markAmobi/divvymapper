class StationsController < ApplicationController

  def index
    # Station.update_stations
    @stations = Station.all
  end

  def show
    @station = Station.find params[:id]
  end
end
