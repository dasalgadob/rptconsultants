class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :check_if_user_has_not_change_password, only: [:edit, :update]

  load_and_authorize_resource
  # GET /users
  # GET /users.json
  def index
    if current_user.is_admin?
      @users = User.all
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @companies = Company.all
  end

  # GET /users/new
  def new
    @user = User.new
    @companies = Company.all
  end

  # GET /users/1/edit
  def edit
    @companies = Company.all
    if @user.company_id != nil
      @company = Company.find( @user.company_id)
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @companies = Company.all
    respond_to do |format|
      if @user.save
        ### Not login when signup due that the admin is the one creating users
        #log_in @user
        flash[:success] = "Registro de usuario exitoso!"
        format.html { redirect_to @user, notice: 'Usuario creado exitosamente.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @companies = Company.all

    respond_to do |format|
      if user_params.include?('password')
        @user.is_new=false
      end
      if current_user.is_admin && !@user.is_admin
        @user.is_new=true
      end

      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Usuario fue actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Usuario fue eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      ## Delete password from params when is not updated
      params[:user].delete(:password) if params[:user][:password].blank?
      params.require(:user).permit(:username, :password, :password_confirmation,
        :is_admin, :company_id, :evaluate, :review, :approve)
    end
end
