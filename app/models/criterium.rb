class Criterium < ApplicationRecord
  belongs_to :degree
  belongs_to :position_type
  scope :score, ->(s) {where score: s}
  scope :degree, -> (d) {where degree_id: d}
  scope :criteria_type_id,-> (c) {where criteria_type_id: c}
  scope :position_type_id, -> (p) { where position_type_id: p }

  def self.load_criteria(page=1, per_page=20)
    includes(:degree, :position_type)
      .paginate(:page => page, :per_page => per_page)
  end
end
