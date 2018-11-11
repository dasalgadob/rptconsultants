class Area < ApplicationRecord
  belongs_to :company
  has_many  :job_titles
  #has_many :valuations, through: :job_title
end
