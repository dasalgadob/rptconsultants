class UpdateValuationsWithoutCompanyId < ActiveRecord::Migration[5.0]
  def up
    update "update job_titles set company_id = areas.company_id "+
    "from  areas "+
    "where job_titles.area_id = areas.id and job_titles.company_id is null"
  end

  def down
    #not implemented
  end
end
