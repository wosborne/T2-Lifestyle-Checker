class PatientsController < ApplicationController
  def new
  end

  def create
    if patient
      add_patient_to_session
      redirect_to new_questionnaire_path, notice: "You have been successfully authenticated"
    else
      respond_to do |format|
        format.html { render :new, alert: "Your details could not be found" }
        format.turbo_stream { flash.now[:alert] = "Your details could not be found" }
      end
    end
  end

  private

  def patient_params
    params.require(:patient).permit(:nhs_number, :surname, :date_of_birth)
  end

  def patient
    @patient ||= AuthenticatePatientIdentityService.call(patient_params)
  end

  def add_patient_to_session
    session[:patient] = patient
  end

end