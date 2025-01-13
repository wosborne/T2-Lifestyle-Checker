class AgeRange < ApplicationRecord
  has_many :question_scores
  validates :min, :max, presence: true, numericality: { only_integer: true }
end