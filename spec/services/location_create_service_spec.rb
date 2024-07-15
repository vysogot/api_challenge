# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LocationCreateService, type: :service do
  subject(:location_create_service) { described_class.new(location_params:) }

  let(:bike_id) { 1 }
  let(:latitude) { 5.441234 }
  let(:longitude) { 6.441234 }
  let(:location_params) { { bike_id:, latitude:, longitude: } }

  describe '#call' do
    let(:bike) { Bike.build(id: bike_id) }
    let(:location) { Location.build(**location_params) }

    specify 'it updates approximate location of a bike' do
      expect(Bike).to receive(:find).with(bike_id).and_return(bike)
      expect(Location).to receive(:create!)
        .with(bike:, latitude:, longitude:)
        .and_return(location)
      expect(ApproximateLocationUpdateService).to receive(:call).with(bike:)
      expect(location_create_service.call).to eq(location)
    end
  end
end
