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
      @user.errors.add(:password, 'Campo vacío. Escribe tu nueva clave.')
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = 'Tu clave fue actualizada correctamente.'
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
      flash[:info] = 'Correo enviado con las instrucciones para restablecer contraseña.'
      redirect_to root_url
    else
      flash.now[:danger] = 'Correo no encontrado.'
      render 'new'
    end
    end

  private

  def user_params
    params.require[:user].permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    unless @user && @user.activated? && @user.authenticated?(:reset, params[:id])
      redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = 'Enlace de activación expirado.'
      redirect_to new_password_reset_url
    end
  end
end
