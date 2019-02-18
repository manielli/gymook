class AddUserReferencesToOccurences < ActiveRecord::Migration[5.2]
  def change
    add_reference :occurences, :user, foreign_key: true
  end
end
