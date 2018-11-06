class Valuation < ApplicationRecord
  belongs_to :job_title
  belongs_to :position_type
  belongs_to :knowledge, class_name: "Criterium"
  belongs_to :skill, class_name: "Criterium"
  belongs_to :definition_supervision, class_name: "Criterium"
  belongs_to :risk_decision, class_name: "Criterium"
  belongs_to :sustainability, class_name: "Criterium"
  belongs_to :area_impact, class_name: "Criterium"
  belongs_to :influence, class_name: "Criterium"
  belongs_to :degree
end
