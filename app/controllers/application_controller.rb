class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #before_action :authenticate_climber!
  #require 'pry'
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def climber_public? climber_id
    Climber.find(climber_id).public if Climber.find(climber_id)
  end

  def belong_to_current_user? climber_id
    climber_id == current_climber.id if climber_signed_in?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :public, :password) }
    #devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :email, :public, :password, :current_password) }
  end

end
