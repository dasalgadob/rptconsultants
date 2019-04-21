class Area < ApplicationRecord
  belongs_to :company
  belongs_to :business_unit, optional: true
  ##Allows that the foreign key to be setup null when area is destroyed
  has_many  :job_titles, dependent: :nullify

  validates :name, presence: true
  #has_many :valuations, through: :job_title

   def self.area_hash_by_name(company_id)
     area_hash={}
     areas = Area.where(company_id: company_id)
     areas.each {|a| area_hash[a[:name]]= a}
     area_hash
   end
end
