class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "debes ingresar una contraseña")
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "Realizado con exito el cambio de contraseña"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = 'Se te envió un correo con las instrucciones para restablecer contraseña'
      redirect_to root_url
    else
      flash.now[:danger] = 'No hemos encontrado la cuenta con esta información'
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = 'Enlace de activación de cuenta ha expiriado.'
      redirect_to new_password_reset_url
    end
  end
end
