class Area < ApplicationRecord
  belongs_to :company
  has_many  :job_titles
end
