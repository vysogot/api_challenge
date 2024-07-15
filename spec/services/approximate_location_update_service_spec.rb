# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApproximateLocationUpdateService, type: :service do
  subject(:approximate_location_update_service) { described_class.new(bike:) }

  let(:bike_id) { 1 }
  let(:latitude) { 5.441234 }
  let(:longitude) { 6.441234 }

  describe '#call' do
    let(:bike) { Bike.build(id: bike_id) }
    let(:approximate_location) { Location.build(bike_id:, latitude:, longitude:) }

    specify 'it updates location of a bike' do
      expect(Location).to receive(:approximate_for_bike_id)
        .with(bike_id)
        .and_return(approximate_location)

      approximate_location_update_service.call

      expect(bike.latitude).to eq(latitude)
      expect(bike.longitude).to eq(longitude)
    end
  end
end
