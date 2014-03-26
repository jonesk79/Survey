require 'spec_helper'

describe 'Survey' do
  describe 'name'
    it 'adds a survey to the database' do
      test_survey = Survey.create({:name => 'Favorite Color'})
      Survey.all.should eq [test_survey]
    end
  end
end
