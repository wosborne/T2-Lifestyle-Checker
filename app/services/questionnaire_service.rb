class QuestionnaireService
  QUESTIONS = [
    {
      id: 1,
      question: "Do you drink on more than 2 days a week?",
      scores: { '21' => 1, '40' => 2, '64' => 3, '100' => 3 },
      answer: "yes"
    },
    {
      id: 2,
      question: "Do you smoke?",
      scores: { '21' => 2, '40' => 2, '64' => 2, '100' => 3 },
      answer: "yes"
    },
    {
      id: 3,
      question: "Do you exercise regularly?",
      scores: { '21' => 1, '40' => 3, '64' => 2, '100' => 1 },
      answer: "no"
    }
  ]

  def initialize(answers, patient)
    @answers = answers
    @patient = patient
  end

  def score
    score = @answers.inject(0) do |sum, answer|
      question = question_by_id(answer[:question_id])

      if answer[:value] == question[:answer]
        sum + score_by_age(question)
      else
        sum
      end
    end
  end

  private

  def question_by_id(question_id)
    QUESTIONS.find { |q| q[:id] == question_id.to_i }
  end

  def score_by_age(question)
    age = patients_age
    ordered_scores = question[:scores].sort_by { |target, score| target.to_i }
    score = ordered_scores.find { |target, score| age <= target.to_i }&.last

    score || 0
  end

  def patients_age
    date_of_birth = Date.parse(@patient['born'])
    age = Date.today.year - date_of_birth.year

    age -= 1 if Date.today < date_of_birth + age.years
    
    age
  end
end