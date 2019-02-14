class CreateOccurences < ActiveRecord::Migration[5.2]
  def change
    create_table :occurences do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :gym_class, foreign_key: true

      t.timestamps
    end
  end
end
