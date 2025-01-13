
class Admin::SettingsController < Admin::AdminBaseController
  def index
    @age_ranges = AgeRange.order(:min)
    @question = Question.includes(:question_scores).all
  end
end
  

