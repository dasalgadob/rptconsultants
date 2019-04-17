class CreateHistorics < ActiveRecord::Migration[5.0]
  def change
    create_table :historics do |t|
      t.string :clase
      t.references :user, foreign_key: true
      t.references :valuation, foreign_key: true
      t.string :previous_fields
      t.string :new_fields

      t.timestamps
    end
  end
end
