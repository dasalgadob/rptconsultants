class Area < ApplicationRecord
  belongs_to :company
  has_many  :job_titles

  validates :name, presence: true
  #has_many :valuations, through: :job_title
end
