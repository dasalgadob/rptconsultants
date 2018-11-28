class JobTitle < ApplicationRecord
  belongs_to :area
  validates :name, presence: true

  def self.job_titles_hash_by_name(company_id)
    job_titles_hash={}
    jts = JobTitle.joins(area: :company).where("companies.id": company_id)
    jts.each {|jt| job_titles_hash[jt[:name]]= jt}
    jts
  end
end
