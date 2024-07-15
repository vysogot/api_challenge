# frozen_string_literal: true

class Location < ApplicationRecord
  belongs_to :bike

  APPROXIMATE_BY_BIKE_ID_QUERY = <<-SQL.squish
    SELECT bike_id,
           round(avg(latitude), 6) AS latitude,
           round(avg(longitude), 6) AS longitude
    FROM
      (SELECT bike_id, latitude, longitude
       FROM locations
       WHERE bike_id = :bike_id
       ORDER BY id DESC
       LIMIT 5) sub
    GROUP BY bike_id
  SQL

  def self.approximate_for_bike_id(bike_id)
    find_by_sql([APPROXIMATE_BY_BIKE_ID_QUERY, { bike_id: }]).first
  end
end
