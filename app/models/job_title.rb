class JobTitle < ApplicationRecord
  has_one :valuation, dependent: :destroy
  belongs_to :area, optional: true
  validates :name, presence: true
  belongs_to :company

  def self.job_titles_hash_by_name(company_id)
    job_titles_hash={}
    jts = JobTitle.joins(area: :company).where("companies.id": company_id)
    jts.each {|jt| job_titles_hash[jt[:name]]= jt}
    job_titles_hash
  end
end
