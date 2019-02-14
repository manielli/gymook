class AddUserReferencesToGymClasses < ActiveRecord::Migration[5.2]
  def change
    add_reference :gym_classes, :user, foreign_key: true
  end
end
