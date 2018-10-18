class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.string :name
      t.references :degree, foreign_key: true
      t.references :position_type, foreign_key: true

      t.timestamps
    end
  end
end
