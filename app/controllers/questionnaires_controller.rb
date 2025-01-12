class QuestionnairesController < ApplicationController
  after_action :remove_patient_from_session, only: :create

  def new
    @questions = QuestionnaireService::QUESTIONS
  end

  def create
    score = questionnaire.score

    if score <= 3
      redirect_to root_path, notice: "Thank you for answering our questions, we don't need to see you at this time. Keep up the good work!"
    else
      redirect_to root_path, alert: "We think there are some simple things you could do to improve you quality of life, please phone to book an appointment"
    end
  end

  private

  def questionnaire
    @questionnaire ||= QuestionnaireService.new(params[:answers], current_patient)
  end

  def questionnaire_params
    params.require(:questionnaire).permit(answers: [:question_id, :value])
  end
end