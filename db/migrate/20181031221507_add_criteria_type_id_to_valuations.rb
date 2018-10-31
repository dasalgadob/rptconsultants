class AddCriteriaTypeIdToValuations < ActiveRecord::Migration[5.0]
  def change
    add_column :criteria, :criteria_type_id, :integer
  end
end
