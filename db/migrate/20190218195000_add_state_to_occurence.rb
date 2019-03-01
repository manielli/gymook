class AddStateToOccurence < ActiveRecord::Migration[5.2]
  def change
    add_column :occurences, :aasm_state, :string
  end
end
