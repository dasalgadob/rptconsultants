class CreateCriteria < ActiveRecord::Migration[5.0]
  def change
    create_table :criteria do |t|
      t.string :criteria_type
      t.integer :score
      t.references :degree, foreign_key: true

      t.timestamps
    end
  end
end
