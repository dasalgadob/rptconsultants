class AddDescriptionPositionTypeToCriteria < ActiveRecord::Migration[5.0]
  def change
    add_column :criteria, :description, :string
    add_reference :criteria, :position_type, foreign_key: true
  end
end
