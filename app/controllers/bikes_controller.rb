# frozen_string_literal: true

class BikesController < ApplicationController
  def show
    BikeCheckLocationService.call(bike:)

    render status: :ok, json: {
      id: bike.id,
      latitude: bike.latitude,
      longitude: bike.longitude
    }
  end

  private

  def bike
    @bike ||= Bike.find(params[:id])
  end
end
