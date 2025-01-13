class Question < ApplicationRecord
  has_many :question_scores
  has_many :age_ranges, through: :question_scores

  validates :question, presence: true
  validates :answer, presence: true
end