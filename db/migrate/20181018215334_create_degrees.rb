class CreateDegrees < ActiveRecord::Migration[5.0]
  def change
    create_table :degrees do |t|
      t.integer :number
      t.integer :minimum
      t.integer :median
      t.integer :maximun

      t.timestamps
    end
  end
end
