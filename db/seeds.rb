# frozen_string_literal: true

bike1 = Bike.create!(name: 'Superbike 1')
bike2 = Bike.create!(name: 'Superbike 2')

10.times.map do
  [bike1, bike2].map do |bike|
    { bike:, latitude: rand * 10, longitude: rand * 10 }
  end
end.then { |locations| Location.create!(locations.flatten) }
