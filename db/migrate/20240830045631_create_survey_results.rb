class CreateSurveyResults < ActiveRecord::Migration[7.1]
  def change
    create_table :survey_results do |t|
      t.references :survey, null: false, foreign_key: true
      t.integer :responses_count, default: 0
      t.integer :positive_responses_count, default: 0
      t.integer :negative_responses_count, default: 0

      t.timestamps
    end
  end
end
