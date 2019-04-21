class BusinessUnit < ApplicationRecord
  belongs_to :company
  has_many :areas, dependent: :nullify
end
