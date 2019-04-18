class AddCompanyToJobTitle < ActiveRecord::Migration[5.0]
  def change
    add_reference :job_titles, :company, foreign_key: true
  end
end
