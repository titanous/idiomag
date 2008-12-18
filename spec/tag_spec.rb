require File.dirname(__FILE__) + '/spec_helper.rb'

describe 'Idiomag::Tag' do
  before(:each) do
    @tag = Idiomag::Tag.new(:alternative_rock)
  end
  
  it 'should require an tag' do
    lambda { Idiomag::Tag.new }.should raise_error(ArgumentError)
  end
  
  it 'should know the tag name' do
    @tag.name.should == 'alternative rock'
  end
  
  it 'should respond_to the correct methods' do
    @tag.respond_to?(:get).should == true
    @tag.respond_to?(:name).should == true
    @tag.respond_to?(:articles).should == true
    @tag.respond_to?(:photos).should == true
    @tag.respond_to?(:videos).should == true
    @tag.respond_to?(:playlist).should == true
    @tag.respond_to?(:tracks).should == true
    @tag.respond_to?(:artists).should == true
  end

  it 'should error on invalid get argument' do
    lambda { @tag.get(:foo) }.should raise_error(ArgumentError)
  end
  
  it 'should error on invalid method' do
    lambda { @tag.foo }.should raise_error(NoMethodError)
  end
  
  it 'should allow symbols and strings as tag names' do
    Idiomag::Tag.new(:alternative_rock)
    Idiomag::Tag.new('Hip-Hop')
  end

  describe 'articles' do
    before(:each) do
      @data = open(Fixtures + 'tag_articles.json').read
      @tag.should_receive(:fetch).and_return(JSON.parse(@data))
    end
    
    it 'should allow prefetching' do
      @tag.get(:articles)
    end
    
    it 'should get articles' do
      @tag.articles[0][:artist].should == 'Trent Reznor'
      @tag.articles[0][:description].blank?.should_not == true
    end
    
    it 'should parse the dates' do
      @tag.articles[0][:date].class.should == Time
    end
  end
  
  describe 'photos' do
    before(:each) do
      @data = open(Fixtures + 'tag_photos.json').read
      @tag.should_receive(:fetch).and_return(JSON.parse(@data))
    end
    
    it 'should allow prefetching' do
      @tag.get(:photos)
    end
    
    it 'should get photos' do
      @tag.photos[0][:title].should =~ /jpg/
      @tag.photos[0][:url].should =~ /jpg/
      @tag.photos[0][:width].class.should == Fixnum
      @tag.photos[0][:height].class.should == Fixnum
    end
    
    it 'should parse the dates' do
      @tag.photos[0][:date].class.should == Time
    end
  end
  
  describe 'videos' do    
    before(:each) do
      @data = open(Fixtures + 'tag_videos.json').read
      @tag.should_receive(:fetch).and_return(JSON.parse(@data))
    end
    
    it 'should allow prefetching' do
      @tag.get(:videos)
    end
    
    it 'should get videos' do
      @tag.videos[0][:location].should =~ /video/
      @tag.videos[0][:info].should =~ /youtube/
      @tag.videos[0][:thumb].should =~ /jpg/
    end
  end
  
  describe 'playlist' do
    before(:each) do
      @data = open(Fixtures + 'tag_playlist.json').read
      @tag.should_receive(:fetch).and_return(JSON.parse(@data))
    end
    
    it 'should allow prefetching' do
      @tag.get(:playlist)
    end
    
    it 'should get playlist' do
      @tag.playlist[0][:location] =~ /mp3/
    end
    
    it 'should respond to #tracks' do
      @tag.get(:tracks)
      @tag.tracks[0][:location] =~ /mp3/
    end
  end
  
  describe 'artists' do
    before(:each) do
      @data = open(Fixtures + 'tag_artists.json').read
      @tag.should_receive(:fetch).and_return(JSON.parse(@data))
    end
    
    it 'should allow prefetching' do
      @tag.get(:artists)
    end
    
    it 'should get artists' do
      @tag.artists['Adelayda'].should == 100
    end
  end
  
  describe 'list' do
    before(:each) do
      @data = open(Fixtures + 'tag_list.txt').read
      Idiomag::Tag.should_receive(:fetch).at_most(1).times.and_return(@data)
      @tag.should_receive(:fetch).at_most(1).times.and_return(@data)
    end
    
    it 'should get the tag list via class method' do
      Idiomag::Tag.list.should include(:alternative_rock)
    end
    
    it 'should get the tag list via instance method' do
      @tag.list.should include('hip-hop')
    end
  end
end
