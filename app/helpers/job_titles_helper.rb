module JobTitlesHelper

  def get_job_title_area_name(job_title)
    job_title.area== nil ? "" : job_title.area.name
  end

  def get_job_title_area_id(job_title)
    if job_title.area == nil
      return ""
    else
      return job_title.area.id
    end
  end
end
