# frozen_string_literal: true

class BikeCheckLocationService
  extend Service

  def initialize(bike:)
    @bike = bike
  end

  def call
    return bike if bike_has_approximates?

    update_approximate_location
    bike
  end

  private

  attr_reader :bike

  def bike_has_approximates?
    bike.latitude && bike.longitude
  end

  def update_approximate_location
    ApproximateLocationUpdateService.call(bike:)
  end
end
