class Criterium < ApplicationRecord
  belongs_to :degree
  scope :score, ->(s) {where score: s}
  scope :degree, -> (d) {where degree_id: d}

  def self.load_criteria(page=1, per_page=20)
    includes(:degree)
      .paginate(:page => page, :per_page => per_page)
  end
end