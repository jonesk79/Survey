require 'active_record'
require './lib/survey'
require './lib/question'
require './lib/response'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "Welcome to Survey!""\n\n"
  "\n\n"
  menu
end

def menu
  choice = nil
  until choice == 'e'
    puts "Press 'a' to add a survey."
    puts "Press 'q' to add questions to a survey."
    puts "Press 'r' to add responses to a survey.""\n\n"

    puts "Press 's' to choose a survey to take.""\n\n"

    puts "Press 'l' to list surveys."
    puts "Press 'd' to delete a survey."
    puts "Press 'e' to exit."

    choice = gets.chomp
    case choice
    when 'a'
      add_survey
    when 'q'
      add_question
    when 'r'
      add_response
    when 's'
      choose_survey
    when 'l'
      list_survey
    when 'd'
      delete_survey
    when 'e'
      puts "Good-bye!"
    else
      puts "That's not a valid option."
    end
  end
end

def add_survey
  puts "What survey would you like to add?"
  survey_name = gets.chomp
  survey = Survey.create({:name => survey_name})
  puts "#{survey.name} has been added."
end

def add_question
  puts "What survey would you like to add questions to?"
  Survey.all.each_with_index { |survey, index| puts "#{survey.id} #{survey.name}" }
  survey_id = gets.chomp.to_i
  survey = Survey.find(survey_id)

  puts "What question would you like to add to this survey?"
  question = gets.chomp
  survey.questions.create(:name => "#{question}")
  puts "#{question} has been added. #{survey.name} updated."
end

def add_response
  puts "What survey would you like to add responses to?"
  Survey.all.each_with_index { |survey, index| puts "#{survey.id} #{survey.name}" }
  survey_id = gets.chomp.to_i
  survey = Survey.find(survey_id)

  puts "What question would you like to add responses to?"
  Question.all.each_with_index { |question, index| puts "#{question.id} #{question.name}"}
  question_id = gets.chomp.to_i
  question = Question.find(question_id)

  puts "What response would you like to add to this question?"
  response = gets.chomp
  question.responses.create(:name => "#{response}")
  puts "#{response} has been added to #{question.name}. #{survey.name} updated."
end

def choose_survey
  puts "What survey would you like to take?"
  Survey.all.each_with_index { |survey, index| puts "#{survey.id} #{survey.name}" }
  survey_id = gets.chomp.to_i
  survey = Survey.find(survey_id)
  survey.questions.each_with_index { |question, index| puts "#{question.id} #{question.name}" }
  puts "What question would you like to answer?"
  question_id = gets.chomp.to_i
  question = Question.find(question_id)
  question.responses.each_with_index { |response, index| puts "#{response.id} #{response.name}"}
  response_id = gets.chomp.to_i
  puts "Thanks for taking this survey."
end

def list_survey
  Survey.all.each_with_index { |survey, index| puts "#{survey.id} #{survey.name}" }
end

def delete_survey
  puts "Which survey would you like to delete?"
  Survey.all.each_with_index { |survey, index| puts "#{survey.id} #{survey.name}" }
  survey_id = gets.chomp.to_i
  survey = Survey.find(survey_id)
  survey.destroy
  puts "#{survey.name} has been deleted."
end

welcome

