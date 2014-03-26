require 'spec_helper'

describe Question do
  it 'adds questions to a survey in the database' do
    test_question = Question.create({:name => "What is your favorite color?"})
    Question.all.should eq [test_question]
  end

  it { should belong_to :survey }

  it { should have_many :responses }
end
