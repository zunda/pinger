class CreateMeasurements < ActiveRecord::Migration[8.0]
  def change
    create_table :measurements do |t|
      t.string :source
      t.string :target
      t.string :note
      t.timestamp :received_at
      t.integer :rtt_ms

      t.timestamps
    end
  end
end
