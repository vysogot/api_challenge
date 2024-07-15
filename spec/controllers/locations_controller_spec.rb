# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  describe 'POST create' do
    let(:latitude) { 10 }
    let(:longitude) { 20 }
    let(:new_latitude) { 30 }
    let(:new_longitude) { 40 }
    let(:expected_latitude) { 20 }
    let(:expected_longitude) { 30 }
    let(:bike) { Bike.create!(name: 'The Bike') }
    let(:other_bike) { Bike.create!(name: 'Other Bike') }
    let(:location) { Location.create!({ bike:, latitude:, longitude: }) }

    before do
      bike and other_bike and location
    end

    specify 'it creates a location for given bike and updates its approximate location' do
      expect(bike.locations.count).to eq(1)

      post :create, params: {
        location: {
          bike_id: bike.id,
          latitude: new_latitude,
          longitude: new_longitude
        }
      }

      expect(response.status).to eq(201)
      expect(bike.locations.count).to eq(2)
      expect(other_bike.locations.count).to eq(0)
      expect(bike.reload.latitude).to eq(expected_latitude)
      expect(bike.reload.longitude).to eq(expected_longitude)
    end
  end
end
