class AddAccessExpireDateToCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :access_expire_date, :datetime
  end
end
