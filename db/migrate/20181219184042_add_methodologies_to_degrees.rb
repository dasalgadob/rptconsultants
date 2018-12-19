class AddMethodologiesToDegrees < ActiveRecord::Migration[5.0]
  def change
    add_column :degrees, :hay, :integer
    add_column :degrees, :ggs, :integer
  end
end
