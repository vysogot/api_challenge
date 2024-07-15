# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bike, type: :model do
  let(:bike) { Bike.create!(name: 'Superbike') }
  let(:other_bike) { Bike.create!(name: 'Other Bike')}
  let(:bike_id) { bike.id }
  let(:raw_locations) do
    [
      [100, 200],
      [2.2, 3.2],
      [3.4, 4.4],
      [4.8, 5.8],
      [6.6, 7.6],
      [10.2, 11.2]
    ]
  end
  let(:approximate_latitude) { 5.44 }
  let(:approximate_longitude) { 6.44 }
  let(:locations) do
    raw_locations.map do |(latitude, longitude)|
      { bike:, latitude:, longitude: }
    end.then { |locations| Location.create!(locations) }
  end
  let(:other_locations) do
    raw_locations.map do |(latitude, longitude)|
      { bike: other_bike, latitude: latitude + 50, longitude: longitude + 100 }
    end.then { |locations| Location.create!(locations) }
  end

  before do
    bike and locations and other_bike and other_locations
  end

  specify 'it calculates avarage from five recent locations for a given bike' do
    location = Location.approximate_for_bike_id(bike_id)

    expect(location.latitude).to eq(approximate_latitude)
    expect(location.longitude).to eq(approximate_longitude)
  end
end
