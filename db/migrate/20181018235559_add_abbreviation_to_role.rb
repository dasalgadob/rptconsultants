class AddAbbreviationToRole < ActiveRecord::Migration[5.0]
  def change
    add_column :roles, :abbreviation, :string
  end
end
