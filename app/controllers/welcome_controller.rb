class WelcomeController < ApplicationController
  skip_before_action :authenticate_patient_session
  
  def index
  end
end
