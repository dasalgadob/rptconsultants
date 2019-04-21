class AddBusinessUnitToArea < ActiveRecord::Migration[5.0]
  def change
    add_reference :areas, :business_unit, foreign_key: true
  end
end
