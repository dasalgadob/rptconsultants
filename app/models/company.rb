class Company < ApplicationRecord
  has_many :areas
  has_many :valuations
  has_many :job_titles
  has_many :business_units, dependent: :nullify

  validates :name, presence: true
end
