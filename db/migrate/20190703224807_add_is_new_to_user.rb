class AddIsNewToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_new, :boolean, default: true
  end
end
