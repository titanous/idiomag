require File.dirname(__FILE__) + '/spec_helper.rb'

describe 'Idiomag::REST' do
  before(:each) do
    Idiomag::Base.api_key = 'foo'
  end
  
  it 'should require an api key' do
    Idiomag::Base.api_key = nil
    lambda { Idiomag::REST.fetch('foo') }.should raise_error(ArgumentError)
  end
  
  it 'should get a resource with no query and parse JSON' do
    @data = open(Fixtures + 'artist_info.json').read
    HTTParty.should_receive(:get).with(Idiomag::API_URL + 'bar/json',:query=>{:key=>'foo'}).and_return(@data)
    Idiomag::REST.fetch('bar').class.should == Hash
  end
  
  it 'should get a resource with a query and parse JSON' do
    @data = open(Fixtures + 'artist_info.json').read
    HTTParty.should_receive(:get).with(Idiomag::API_URL + 'bar/json',:query=>{:key=>'foo',:chunky=>'bacon'}).and_return(@data)
    Idiomag::REST.fetch('bar',:chunky=>'bacon').class.should == Hash
  end
  
  it 'should get a resource with no query and no JSON parsing' do
    @data = open(Fixtures + 'tag_list.txt').read
    HTTParty.should_receive(:get).with(Idiomag::API_URL + 'bar/json',:query=>{:key=>'foo'}).and_return(@data)
    Idiomag::REST.fetch('bar',{},false).class.should == String
  end
end