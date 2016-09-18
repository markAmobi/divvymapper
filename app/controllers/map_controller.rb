class MapController < ApplicationController

  def map
    @stations = Station.all
  end
end
