
class Admin::SettingsController < Admin::AdminBaseController
  def index
    @age_ranges = AgeRange.order(:min)
    @questions = Question.includes(question_scores: [ :age_range ])
  end
end
  

