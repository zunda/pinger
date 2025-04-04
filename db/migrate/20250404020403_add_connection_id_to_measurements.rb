class AddConnectionIdToMeasurements < ActiveRecord::Migration[8.0]
  def change
    add_column :measurements, :connection, :uuid
  end
end
