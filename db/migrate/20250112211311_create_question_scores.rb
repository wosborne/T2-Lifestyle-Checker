class CreateQuestionScores < ActiveRecord::Migration[8.0]
  def change
    create_table :question_scores do |t|
      t.references :question, null: false, foreign_key: true
      t.references :age_range, null: false, foreign_key: true
      t.integer :score
      
      t.timestamps
    end
  end
end
