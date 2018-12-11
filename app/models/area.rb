class Area < ApplicationRecord
  belongs_to :company
  has_many  :job_titles

  validates :name, presence: true
  #has_many :valuations, through: :job_title

   def self.area_hash_by_name(company_id)
     area_hash={}
     areas = Area.where(company_id: company_id)
     areas.each {|a| area_hash[a[:name]]= a}
     area_hash
   end
end
