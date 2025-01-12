class PatientsController < ApplicationController
  skip_before_action :authenticate_patient_session
  before_action :remove_patient_from_session

  def new
  end

  def create
    if patient && patient_eligible?
      add_patient_to_session
      redirect_to new_questionnaire_path, notice: "You have been successfully authenticated"

    elsif patient && !patient_eligible?
      redirect_to root_path, alert: "You are not eligble for this service"

    else
      remove_patient_from_session
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

  def patient_eligible?
    patient['born'] < 16.years.ago
  end
end