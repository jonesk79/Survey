require 'active_record'
require 'rspec'
require 'shoulda-matchers'

require 'survey'
require 'question'
require 'response'

database_configurations = YAML::load(File.open('./db/config.yml'))
test_configuration = database_configurations['test']
ActiveRecord::Base.establish_connection(test_configuration)

Rspec.configure do |config|
  config.after(:each) do
    Survey.all.each{ |survey| survey.destroy }
    Question.all.each{ |question| question.destroy }
    Response.all.each{ |response| response.destroy }
  end
end
