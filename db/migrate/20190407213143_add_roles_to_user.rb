class AddRolesToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :evaluate, :boolean
    add_column :users, :review, :boolean
    add_column :users, :approve, :boolean
  end
end
