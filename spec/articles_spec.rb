require File.dirname(__FILE__) + '/spec_helper.rb'

describe 'Idiomag::Articles' do
  before(:each) do
    @articles = Idiomag::Articles.new
  end
  
  it 'should respond_to the correct methods' do
    @articles.respond_to?(:get).should == true
    @articles.respond_to?(:latest).should == true
    @articles.respond_to?(:featured).should == true
  end
  
  it 'should error on invalid get argument' do
    lambda { @articles.get(:foo) }.should raise_error(ArgumentError)
  end
  
  it 'should error on invalid method' do
    lambda { @articles.foo }.should raise_error(NoMethodError)
  end
  
  describe 'latest' do
    before(:each) do
      @data = open(Fixtures + 'articles_latest.json').read
      @articles.should_receive(:fetch).and_return(JSON.parse(@data))
    end
    
    it 'should allow prefetching' do
      @articles.get(:latest)
    end
    
    it 'should get latest articles' do
      @articles.latest[0][:artist].should == 'K-Drama'
      @articles.latest[0][:description].blank?.should_not == true
    end
    
    it 'should parse the dates' do
      @articles.latest[0][:date].class.should == Time
    end
  end
  
  describe 'featured' do
    before(:each) do
      @data = open(Fixtures + 'articles_featured.json').read
      @articles.should_receive(:fetch).and_return(JSON.parse(@data))
    end
    
    it 'should allow prefetching' do
      @articles.get(:featured)
    end
    
    it 'should get featured articles' do
      @articles.featured[0][:artist].should == 'Coldplay'
      @articles.featured[0][:description].blank?.should_not == true
    end
    
    it 'should parse the dates' do
      @articles.featured[0][:date].class.should == Time
    end
  end
end