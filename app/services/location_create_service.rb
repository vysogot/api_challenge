# frozen_string_literal: true

class LocationCreateService
  extend Service

  def initialize(location_params:)
    @bike_id = location_params[:bike_id]
    @latitude = location_params[:latitude]
    @longitude = location_params[:longitude]
  end

  def call
    ActiveRecord::Base.transaction do
      Location.create!(bike:, latitude:, longitude:).tap do
        ApproximateLocationUpdateService.call(bike:)
      end
    end
  end

  private

  def bike
    @bike ||= Bike.find(bike_id)
  end

  attr_reader :bike_id, :latitude, :longitude
end
