class Valuation < ApplicationRecord
  belongs_to :job_title
  #belongs_to :area, through: :job_title
  belongs_to :position_type
  belongs_to :knowledge, class_name: "Criterium"
  belongs_to :skill, class_name: "Criterium"
  belongs_to :definition_supervision, class_name: "Criterium"
  belongs_to :risk_decision, class_name: "Criterium"
  belongs_to :sustainability, class_name: "Criterium"
  belongs_to :area_impact, class_name: "Criterium"
  belongs_to :influence, class_name: "Criterium"
  belongs_to :degree
  belongs_to :company

  scope :score, ->(s) {where score: s}
  scope :degree, ->(d) {where degree: d}
  scope :position_type, ->(pt) {where position_type: pt}

  def self.load_valuations(company,page=1, per_page=20)
    joins(:degree, :company, :position_type, :job_title)
      .paginate(:page => page, :per_page => per_page).where(company_id: company.id)
  end
end
