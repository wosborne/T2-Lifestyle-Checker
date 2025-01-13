# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create!(email_address: "darth@vader.com", password: "deathstar2", password_confirmation: "deathstar2")

drink = Question.create!(question: "Do you drink on more than 2 days a week?", answer: "yes")
smoke = Question.create!(question: "Do you smoke?", answer: "yes")
excer = Question.create!(question: "Do you exercise regularly?", answer: "no")

twenty_one = AgeRange.create!(min: 16, max: 21)
thirty_nine = AgeRange.create!(min: 21, max: 39)
sixty_four = AgeRange.create!(min: 40, max: 64)
one_hundred = AgeRange.create!(min: 65, max: 100)

QuestionScore.create!(question: drink, age_range: twenty_one, score: 1)
QuestionScore.create!(question: smoke, age_range: thirty_nine, score: 2)
QuestionScore.create!(question: excer, age_range: sixty_four, score: 3)
QuestionScore.create!(question: drink, age_range: one_hundred, score: 3)

QuestionScore.create!(question: drink, age_range: twenty_one, score: 2)
QuestionScore.create!(question: smoke, age_range: thirty_nine, score: 2)
QuestionScore.create!(question: excer, age_range: sixty_four, score: 2)
QuestionScore.create!(question: drink, age_range: one_hundred, score: 3)

QuestionScore.create!(question: drink, age_range: twenty_one, score: 1)
QuestionScore.create!(question: smoke, age_range: thirty_nine, score: 3)
QuestionScore.create!(question: excer, age_range: sixty_four, score: 2)
QuestionScore.create!(question: drink, age_range: one_hundred, score: 1)