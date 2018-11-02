class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.references :role
      t.references :user

      t.timestamps
    end
  end
end
