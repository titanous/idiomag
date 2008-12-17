require File.dirname(__FILE__) + '/spec_helper.rb'

describe 'Idiomag::Artist' do
  before(:each) do
    @artist = Idiomag::Artist.new('Anberlin')
  end
  
  it 'should require an artist' do
    lambda { Idiomag::Artist.new }.should raise_error(ArgumentError)
  end
  
  it 'should respond_to the correct methods' do
    @artist.respond_to?(:get).should == true
    @artist.respond_to?(:links).should == true
    @artist.respond_to?(:related).should == true
    @artist.respond_to?(:tags).should == true
    @artist.respond_to?(:articles).should == true
    @artist.respond_to?(:photos).should == true
    @artist.respond_to?(:videos).should == true
    @artist.respond_to?(:playlist).should == true
    @artist.respond_to?(:tracks).should == true
  end

  describe 'info' do
    before(:each) do
      @data = open(Fixtures + 'artist_info.json').read
      @artist.should_receive(:fetch).and_return(JSON.parse(@data))
    end
    
    it 'should allow prefetching' do
      @artist.get(:info)
    end
    
    it 'should get links' do
      @artist.links.should include('http://www.anberlin.com')
    end
    
    it 'should get related artists' do
      @artist.related['Relient K'].should include('http://www.idiomag.com/artist/relient_k/')
    end
  end
  
  describe 'tags' do
    before(:each) do
      @data = open(Fixtures + 'artist_tags.json').read
      @artist.should_receive(:fetch).and_return(JSON.parse(@data))
    end
    
    it 'should allow prefetching' do
      @artist.get(:tags)
    end
    
    it 'should get tags' do
      @artist.tags[:alternative_rock].should == 0.37
    end
  end
  
  describe 'articles' do
    before(:each) do
      @data = open(Fixtures + 'artist_articles.json').read
      @artist.should_receive(:fetch).and_return(JSON.parse(@data))
    end
    
    it 'should allow prefetching' do
      @artist.get(:articles)
    end
    
    it 'should get articles' do
      @artist.articles[0][:artist].should == 'Anberlin'
      @artist.articles[0][:description].blank?.should_not == true
      @artist.articles[0][:source_url].blank?.should_not == true
    end
    
    it 'should parse the dates' do
      @artist.articles[0][:date].class.should == Time
    end
  end
  
  describe 'photos' do
    before(:each) do
      @data = open(Fixtures + 'artist_photos.json').read
      @artist.should_receive(:fetch).and_return(JSON.parse(@data))
    end
    
    it 'should allow prefetching' do
      @artist.get(:photos)
    end
    
    it 'should get photos' do
      @artist.photos[0][:title].should =~ /jpg/
      @artist.photos[0][:url].should =~ /jpg/
      @artist.photos[0][:width].class.should == Fixnum
      @artist.photos[0][:height].class.should == Fixnum
    end
    
    it 'should parse the dates' do
      @artist.photos[0][:date].class.should == Time
    end
  end
  
  describe 'videos' do    
    before(:each) do
      @data = open(Fixtures + 'artist_videos.json').read
      @artist.should_receive(:fetch).and_return(JSON.parse(@data))
    end
    
    it 'should allow prefetching' do
      @artist.get(:videos)
    end
    
    it 'should get videos' do
      @artist.videos[0][:location].should =~ /video/
      @artist.videos[0][:info].should =~ /youtube/
      @artist.videos[0][:thumb].should =~ /jpg/
    end
  end
  
  describe 'playlist' do
    before(:each) do
      @data = open(Fixtures + 'artist_playlist.json').read
      @artist.should_receive(:fetch).and_return(JSON.parse(@data))
    end
    
    it 'should allow prefetching' do
      @artist.get(:playlist)
    end
    
    it 'should get playlist' do
      @artist.playlist[0][:location] =~ /mp3/
    end
    
    it 'should respond to #tracks' do
      @artist.get(:tracks)
      @artist.tracks[0][:location] =~ /mp3/
    end
  end
end
