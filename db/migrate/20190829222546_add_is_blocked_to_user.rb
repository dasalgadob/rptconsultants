class AddIsBlockedToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_blocked, :boolean, default: false
    add_column :users, :failed_attempts, :integer, default: 0
  end
end
