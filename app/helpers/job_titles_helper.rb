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

  def get_breadcrumb_for_job_title(job_title)
    if job_title.area
    return [['Menu',menu_path],
     [I18n.t('companies'),companies_path],[job_title.company.name,company_path(job_title.company)],
      ['Areas', company_areas_path(job_title.company)],
       [job_title.area.name, area_path(job_title.area)]]
    else
      return [['Companies',companies_path],[job_title.company.name,company_path(job_title.company)],
       ['Cargos', company_job_titles_path(job_title.company)]]
    end
  end#End function

  def get_form_for_parameter(submit_string, job_title, area= nil)
    if !job_title.area && submit_string == 'Crear'
      return [job_title.company, job_title]
    else
      return [area, job_title]
    end
  end

  #Return the proper path for the link with string "Volver" depending on if it
  #has an area or not.
  def get_path_for_return_job_title(job_title)
    if job_title.area
      return area_path(job_title.area.id)
    else
      return company_job_titles_path(job_title.company)
    end
  end

end
