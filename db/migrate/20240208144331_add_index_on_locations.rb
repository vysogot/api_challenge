# frozen_string_literal: true

class AddIndexOnLocations < ActiveRecord::Migration[7.1]
  disable_ddl_transaction!

  def change
    add_index :locations, :bike_id
  end
end
