class ChangeQuestionColumn < ActiveRecord::Migration
  def change
    rename_column :responses, :questions_id, :question_id
  end
end
