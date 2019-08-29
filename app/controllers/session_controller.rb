class SessionController < ApplicationController

  skip_before_action :check_if_user_has_not_change_password, only: [:destroy]

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.is_blocked
      flash[:warning] = 'El usuario se encuentra bloqueado consulte al administrador del sistema para hacer cambio de contraseña.'
      render 'new'
    elsif user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in(user)
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      if user.is_new
        flash[:warning] = 'Es necesario que haga cambio de contraseña antes de usar la aplicación.'
        redirect_to edit_user_path(user.id)
      else
        redirect_to "/menu"
      end
    else
      ##If user exists change failed attemps and is_blocked state if it applies
      if user
        user.failed_attempts = user.failed_attempts + 1
        if user.failed_attempts >= 3
          user.is_blocked = true
        end
        user.save
      end
      # Create an error message.
      flash.now[:danger] = 'Invalido usuario o contraseña.'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
