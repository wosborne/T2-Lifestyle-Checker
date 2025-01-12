class ApplicationController < ActionController::Base
  include Authentication
  before_action :authenticate_patient_session
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def authenticate_patient_session
    redirect_to new_patient_path unless current_patient
  end

  helper_method :current_patient
  def current_patient
    @current_patient ||= session[:patient]
  end

  helper_method :add_patient_to_session
  def add_patient_to_session
    session[:patient] = patient
  end

  helper_method :remove_patient_from_session
  def remove_patient_from_session
    session.delete(:patient)
  end
end
