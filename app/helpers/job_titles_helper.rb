module JobTitlesHelper

  def get_job_title_area_name(job_title)
    job_title.area== nil ? "" : job_title.area.name
  end
end
