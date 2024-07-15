# frozen_string_literal: true

class ApproximateLocationUpdateService
  extend Service

  def initialize(bike:)
    @bike = bike
  end

  def call
    return if location.nil?

    bike.update!(latitude:, longitude:)
  end

  private

  attr_reader :bike

  def latitude
    location.latitude
  end

  def longitude
    location.longitude
  end

  def location
    @location ||= Location.approximate_for_bike_id(bike.id)
  end
end
