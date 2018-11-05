class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: "No estas autorizado para acceder a esta página." }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  def hello
    render html: "Hello"
  end

  include SessionHelper
end
