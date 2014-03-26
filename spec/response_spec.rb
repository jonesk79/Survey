require 'spec_helper'

describe Response do
  it 'adds responses for a question to a survey in the database' do
    test_response = Response.create({:name => "Red"})
    Response.all.should eq [test_response]
  end

  it { should belong_to :question }
end
