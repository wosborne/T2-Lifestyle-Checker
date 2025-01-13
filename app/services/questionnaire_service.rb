class QuestionnaireService
  def initialize(answers, patient)
    @answers = answers
    @patient = patient
  end

  def score
    @answers.inject(0) do |sum, answer|
      question = question_by_id(answer[:question_id])

      if answer[:value] == question.answer
        sum + score_by_age(question)
      else
        sum
      end
    end
  end

  private

  def question_by_id(question_id)
    Question.find(question_id)
  end

  def score_by_age(question)
    age = patients_age
    age_range = age_ranges.find_by('min <= ? AND max >= ?', age, age)
    question_score = QuestionScore.find_by(question: question, age_range: age_range)

    question_score ? question_score.score : 0
  end

  def age_ranges
    @age_ranges ||= AgeRange.order(:min)
  end

  def patients_age
    date_of_birth = Date.parse(@patient['born'])
    age = Date.today.year - date_of_birth.year
    age -= 1 if Date.today < date_of_birth + age.years
    age
  end
end