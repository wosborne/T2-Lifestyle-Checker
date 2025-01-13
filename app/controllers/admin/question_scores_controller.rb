class Admin::QuestionScoresController < Admin::AdminBaseController
  def update
    question_scores_params.each do |question_score_params|
      question_score = QuestionScore.find(question_score_params[:id])
      question_score.update(question_score_params.permit(:score))
    end

    redirect_to admin_settings_path, notice: "Question scores updated successfully."
  end

  private

  def question_scores_params
    params.require(:question_scores)
  end
end