module QuestionsHelper
  def setup_seed_data
    drink = Question.create!(question: "Do you drink on more than 2 days a week?", answer: "yes")
    smoke = Question.create!(question: "Do you smoke?", answer: "yes")
    excer = Question.create!(question: "Do you exercise regularly?", answer: "no")

    twenty_one = AgeRange.create!(min: 16, max: 21)
    thirty_nine = AgeRange.create!(min: 21, max: 39)
    sixty_four = AgeRange.create!(min: 40, max: 64)
    one_hundred = AgeRange.create!(min: 65, max: 100)

    QuestionScore.create!(question: drink, age_range: twenty_one, score: 1)
    QuestionScore.create!(question: drink, age_range: thirty_nine, score: 2)
    QuestionScore.create!(question: drink, age_range: sixty_four, score: 3)
    QuestionScore.create!(question: drink, age_range: one_hundred, score: 3)

    QuestionScore.create!(question: smoke, age_range: twenty_one, score: 2)
    QuestionScore.create!(question: smoke, age_range: thirty_nine, score: 2)
    QuestionScore.create!(question: smoke, age_range: sixty_four, score: 2)
    QuestionScore.create!(question: smoke, age_range: one_hundred, score: 3)

    QuestionScore.create!(question: excer, age_range: twenty_one, score: 1)
    QuestionScore.create!(question: excer, age_range: thirty_nine, score: 3)
    QuestionScore.create!(question: excer, age_range: sixty_four, score: 2)
    QuestionScore.create!(question: excer, age_range: one_hundred, score: 1)
  end
end