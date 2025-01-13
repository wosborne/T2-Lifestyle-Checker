class ApplicationController < ActionController::Base
  before_action :authenticate_patient_session
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def authenticate_patient_session
    redirect_to new_patient_path unless session[:patient]
  end
end
