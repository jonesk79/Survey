require 'active_record'
require 'spec_helper'

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
    puts "Press 'e' to exit."
    choice = gets.chomp
    case choice
    when 's'
      add_survey
    when 'q'
      add_question
    when 'r'
      add_response
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
  survey = Survey.create({:name => "Favorite Color"})
  puts "'#{survey_name}' has been added."
end

def add_question

end

welcome
