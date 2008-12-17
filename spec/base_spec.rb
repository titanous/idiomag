require File.dirname(__FILE__) + '/spec_helper.rb'

describe 'Idiomag::Base' do
  before do
    Idiomag::Base.api_key = 'foo'
  end
  
  it 'should have the api url' do
    Idiomag::API_URL.should == 'http://www.idiomag.com/api/'
  end
  
  it 'should be able to access the api key' do
    Idiomag::Base.api_key.should == 'foo'
  end
end