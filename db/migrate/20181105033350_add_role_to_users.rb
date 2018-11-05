class AddRoleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :roles, :user, foreign_key: true
  end
end
