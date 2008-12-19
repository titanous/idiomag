require File.dirname(__FILE__) + '/spec_helper'

describe 'Idiomag::Recommendation' do
  before(:each) do
    @recommendation = Idiomag::Recommendation.new(:apml=>'foo')
  end
  
  it 'should error if not given correct arguments' do
    lambda { Idiomag::Recommendation.new }.should raise_error(ArgumentError)
  end
  
  it 'should respond_to the correct methods' do
    @recommendation.respond_to?(:get).should == true
    @recommendation.respond_to?(:artists).should == true
    @recommendation.respond_to?(:articles).should == true
  end

  it 'should error on invalid get argument' do
    lambda { @recommendation.get(:foo) }.should raise_error(ArgumentError)
  end
  
  it 'should error on invalid method' do
    lambda { @recommendation.foo }.should raise_error(NoMethodError)
  end
  
  describe 'network lookup' do
    it 'should allow valid networks' do
      [:lastfm,:mog,:ilike,:mystrands,:projectplaylist,:imeem,:pandora,:bebo,:myspace,:songza].each do |n|
        Idiomag::Recommendation.new(:network=>n,:user=>'foo')
      end
    end
      
    it 'should not allow invalid networks' do
      lambda { Idiomag::Recommendation.new(:network=>:bar,:username=>'foo') }.should raise_error(ArgumentError)
    end
    
    it 'should error if missing user' do
      lambda { Idiomag::Recommendation.new(:network=>:bar) }.should raise_error(ArgumentError)
    end
  end
  
  describe 'artists lookup' do
    it 'should require an Array' do
      lambda { Idiomag::Recommendation.new(:artist=>:foo) }.should raise_error(ArgumentError)
    end
    
    it 'should allow multiple artists' do
      @data = open(Fixtures + 'recommendation_articles.json').read
      Idiomag::REST.should_receive(:fetch).with('recommendation/articles',:artists=>['Anberlin','Relient K']).and_return(JSON.parse(@data))
      Idiomag::Recommendation.new(:artists=>['Anberlin','Relient K']).articles
    end
  end
  
  describe 'articles' do
    before(:each) do
      @data = open(Fixtures + 'recommendation_articles.json').read
      Idiomag::REST.should_receive(:fetch).with('recommendation/articles',:apml=>'foo').and_return(JSON.parse(@data))
    end
    
    it 'should allow prefetching' do
      @recommendation.get(:articles)
    end
    
    it 'should get articles' do
      @recommendation.articles[0][:artist].should == 'Relient K'
      @recommendation.articles[0][:description].blank?.should_not == true
    end
    
    it 'should parse the dates' do
      @recommendation.articles[0][:date].class.should == Time
    end
  end
  
  describe 'artists' do
    before(:each) do
      @data = open(Fixtures + 'recommendation_artists.json').read
      Idiomag::REST.should_receive(:fetch).with('recommendation/artists',:apml=>'foo').and_return(JSON.parse(@data))
    end
    
    it 'should allow prefetching' do
      @recommendation.get(:artists)
    end
    
    it 'should get artists' do
      @recommendation.artists['Project 86'].should == 100
    end
  end
end