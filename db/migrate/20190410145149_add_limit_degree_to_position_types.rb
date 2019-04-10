class AddLimitDegreeToPositionTypes < ActiveRecord::Migration[5.0]
  def change
    add_column :position_types, :minimum_degree, :integer
    add_column :position_types, :maximum_degree, :integer
  end
end
