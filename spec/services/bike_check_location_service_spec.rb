# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BikeCheckLocationService, type: :service do
  subject(:bike_fetch_service) { described_class.new(bike:) }

  let(:id) { 1 }

  describe '#call' do
    context 'when bike has no location' do
      let(:bike) { Bike.build(id:) }

      specify 'it calls update service' do
        expect(ApproximateLocationUpdateService).to receive(:call).with(bike:)
        expect(bike_fetch_service.call).to eq(bike)
      end
    end

    context 'when bike has location' do
      let(:bike) { Bike.build(id:, latitude: 5, longitude: 10) }

      specify 'it doesnt call update service' do
        expect(ApproximateLocationUpdateService).not_to receive(:call)
        expect(bike_fetch_service.call).to eq(bike)
      end
    end
  end
end
