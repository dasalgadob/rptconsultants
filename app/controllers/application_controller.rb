class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionHelper

  before_action :check_if_user_has_not_change_password,  if: proc { current_user && current_user.is_new }

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


  private

  def check_if_user_has_not_change_password
    flash[:warning] = 'Es necesario que haga cambio de contraseña antes de usar la aplicación.'
    redirect_to edit_user_path(current_user.id)
  end
end
