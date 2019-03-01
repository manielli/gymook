class CreateGymClasses < ActiveRecord::Migration[5.2]
  def change
    create_table :gym_classes do |t|
      t.string :class_type
      t.integer :maximum_clients
      t.text :description
      t.float :cost

      t.timestamps
    end
  end
end
