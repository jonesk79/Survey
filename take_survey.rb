require 'active_record'
require './lib/survey'
require './lib/question'
require './lib/response'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "Welcome to Survey taker!"
  menu
end

def menu
  choice = nil
  until choice == 'e'
    puts "Press 's' to add a survey."
    puts "Press 'q' to add questions to a survey."
    puts "Press 'r' to add responses to a survey."
    puts "Press 'l' to list surveys."
    puts "Press 'd' to delete a survey."
    puts "Press 'e' to exit."
    choice = gets.chomp
    case choice
    when 's'
      add_survey
    when 'q'
      add_question
    when 'r'
      add_response
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
  puts "#{survey_name} has been added."
end

def list_survey
  Survey.all.each_with_index { |survey, index| puts "#{index} #{survey.name}" }
end

def add_question
  puts "What survey would you like to add questions to?"
  Survey.all.each_with_index { |survey, index| puts "#{index} #{survey.name}" }
  survey_id = gets.chomp.to_i
  survey = Survey.find(survey_id)
  puts "What question would you like to add to this survey?"
  question = gets.chomp
  survey.questions.create(:name => "#{question}")
  puts "#{question} has been added. #{survey.name} updated."
end

def add_response
  puts "What survey would you like to add responses to?"
  Survey.all.each_with_index { |survey, index| puts "#{index} #{survey.name}" }
  survey_id = gets.chomp.to_i
  survey = Survey.find(survey_id)
  puts "What question would you like to add responses to?"
  Question.all.each_with_index { |question, index| puts "#{index} #{question.name}"}
  question_id = gets.chomp.to_i
  question = Question.find(question_id)
  put "What response would you like to add to this question?"
  response = gets.chomp
  survey.questions.responses.create(:name => "#{response}")
  puts "#{response} has been added to #{question.name}. #{survey.name} updated."
end

def delete_survey

end

welcome
