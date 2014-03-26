require 'spec_helper'

describe Survey do
  it 'adds a survey to the database' do
    test_survey = Survey.create({:name => 'Favorite Color'})
    Survey.all.should eq [test_survey]
  end

  it { should have_many :questions }
end
