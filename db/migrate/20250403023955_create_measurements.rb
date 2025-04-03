class CreateMeasurements < ActiveRecord::Migration[8.0]
  def change
    create_table :measurements do |t|
      t.string :source
      t.string :target
      t.string :note
      t.timestamp :sent_at
      t.timestamp :received_at

      t.timestamps
    end
  end
end
