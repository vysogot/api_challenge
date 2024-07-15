# frozen_string_literal: true

class LocationsController < ApplicationController
  def create
    location = LocationCreateService.call(location_params:)

    render status: :created, json: {
      id: location.id,
      bike_id: location.bike_id,
      latitude: location.latitude,
      longitude: location.longitude
    }
  end

  private

  def location_params
    params.require(:location).permit(:bike_id, :latitude, :longitude)
  end
end
