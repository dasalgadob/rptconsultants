class AddForeignKeyToCriterium < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :criteria, :criteria_types, column: :criteria_type_id
  end
end
