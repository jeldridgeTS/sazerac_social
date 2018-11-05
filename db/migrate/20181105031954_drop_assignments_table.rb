class DropAssignmentsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :assignments
  end
end
