class Valuation < ApplicationRecord
  belongs_to :job_title
  belongs_to :position_type
  belongs_to :knowledge
  belongs_to :skill
  belongs_to :definition_supervision
  belongs_to :risk_decision
  belongs_to :sustainability
  belongs_to :area_impact
  belongs_to :influence
  belongs_to :degree
end
