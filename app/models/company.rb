class Company < ApplicationRecord
  has_many :areas, dependent: :destroy
  has_many :valuations, dependent: :destroy
  has_many :job_titles, dependent: :destroy
  has_many :business_units, dependent: :destroy
  has_many :users, dependent: :nullify
  validates :name, presence: true

  def self.execute_sql(*sql_array)
   connection.execute(send(:sanitize_sql_array, sql_array))
  end

  def self.get_maximum_valuations_group_by_area_by_degree(degree, company)
    execute_sql("
    select coalesce(max(count_high),0) as count_high, coalesce(max(count_low),0) as count_low
    from (
    select job_titles.area_id,
    count(job_titles.area_id) filter(where valuations.score between degrees.minimum and degrees.median ) as count_low,
    count(job_titles.area_id) filter(where valuations.score between degrees.median + 1 and degrees.maximun ) as count_high
    ,count(job_titles.area_id) as total
    from valuations
    join job_titles on  job_titles.id = valuations.job_title_id
    join degrees on valuations.degree_id = degrees.id
    where valuations.degree_id=? and valuations.company_id =?
    group by job_titles.area_id
    ) t",degree, company )
  end
end
