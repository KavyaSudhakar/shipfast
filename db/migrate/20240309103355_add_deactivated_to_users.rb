class AddDeactivatedToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :deactivated, :boolean, default: false
  end
end
