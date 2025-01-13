class QuestionScore < ApplicationRecord
  belongs_to :question
  belongs_to :age_range

  validates :score, presence: true, numericality: { only_integer: true }
end