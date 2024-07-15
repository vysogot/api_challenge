# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BikesController, type: :controller do
  describe 'GET show' do
    let(:name) { 'The Bike' }
    let(:latitude) { 55.666137 }
    let(:longitude) { 12.580222 }
    let(:parsed_response) { JSON.parse(response.body).deep_symbolize_keys! }
    let(:other_bike) { Bike.create!(name: 'Other Bike') }

    before do
      bike and other_bike and locations
    end

    context 'when bike has approximate location' do
      let(:bike) { Bike.create!(name:, latitude:, longitude:) }
      let(:locations) { Location.create!({ bike: other_bike, latitude:, longitude: }) }

      specify 'it gets the bike with its location' do
        get :show, params: { id: bike.id }

        expect(response.status).to eq(200)
        expect(parsed_response[:id]).to eq(bike.id)
        expect(parsed_response[:latitude]).to eq(latitude)
        expect(parsed_response[:longitude]).to eq(longitude)
      end
    end

    context 'when bike has no approximate location' do
      let(:bike) { Bike.create!(name:) }
      let(:second_latitude) { 10.384921 }
      let(:second_longitude) { 4.123421 }
      let(:expected_latitude) { 33.025529 }
      let(:expected_longitude) { 8.351821 }
      let(:locations) do
        Location.create!([
                           { bike: other_bike, latitude:, longitude: },
                           { bike:, latitude:, longitude: },
                           { bike:, latitude: second_latitude, longitude: second_longitude }
                         ])
      end

      specify 'it calculates the location and gets the bike with it' do
        get :show, params: { id: bike.id }

        expect(response.status).to eq(200)
        expect(parsed_response[:id]).to eq(bike.id)
        expect(parsed_response[:latitude]).to eq(expected_latitude)
        expect(parsed_response[:longitude]).to eq(expected_longitude)
      end
    end
  end
end
