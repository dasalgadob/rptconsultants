class BusinessUnit < ApplicationRecord
  belongs_to :company
  has_many :areas, dependent: :nullify

  def name_to_upcase
    self.name.upcase
  end
end
