class AddTestUserToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :test_user, :boolean, default: false
  end
end
