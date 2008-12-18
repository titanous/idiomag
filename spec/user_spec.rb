require File.dirname(__FILE__) + '/spec_helper.rb'

describe 'Idiomag::User' do
  before(:each) do
    @user = Idiomag::User.new('Titanous')
  end
  
  it 'should require an user' do
    lambda { Idiomag::User.new }.should raise_error(ArgumentError)
  end
  
  it 'should know the username' do
    @user.user.should == 'Titanous'
  end
  
  it 'should respond_to the correct methods' do
    @user.respond_to?(:name).should == true
    @user.respond_to?(:user).should == true
    @user.respond_to?(:get).should == true
    @user.respond_to?(:email).should == true
    @user.respond_to?(:url).should == true
    @user.respond_to?(:tags).should == true
    @user.respond_to?(:artists).should == true
    @user.respond_to?(:articles).should == true
    @user.respond_to?(:loved_articles).should == true
    @user.respond_to?(:photos).should == true
    @user.respond_to?(:videos).should == true
    @user.respond_to?(:playlist).should == true
    @user.respond_to?(:tracks).should == true
  end
  
  describe 'info' do
    before(:each) do
      @data = open(Fixtures + 'user_info.json').read
      @user.should_receive(:fetch).and_return(JSON.parse(@data))
    end

    it 'should allow prefetching' do
      @user.get(:info)
    end

    it 'should get the users name' do
      @user.name.should == 'Jonathan'
    end
    
    it 'should get the users email hash' do
      @user.email.should == 'e6fbe7774a09bd85aabc4943433858e82ce71e0f'
    end
    
    it 'should get the users profile url' do
      @user.url.should include('http://www.idiomag.com/user/Titanous')
    end
    
    it 'should get the users artists' do
      @user.artists['Relient K'].should == 1.0
    end
    
    it 'should get the users tags' do
      @user.tags[:alternative_rock].should == 0.67
    end
  end
  
  describe 'articles' do
    before(:each) do
      @data = open(Fixtures + 'user_articles.json').read
      @user.should_receive(:fetch).and_return(JSON.parse(@data))
    end
    
   it 'should allow prefetching' do
      @user.get(:articles)
    end
    
    it 'should get articles' do
      @user.articles[0][:artist].should == 'BarlowGirl'
      @user.articles[0][:description].blank?.should_not == true
    end
    
    it 'should parse the dates' do
      @user.articles[0][:date].class.should == Time
    end
  end
  
  describe 'loved articles' do
     before(:each) do
       @data = open(Fixtures + 'user_lovedarticles.json').read
       @user.should_receive(:fetch).and_return(JSON.parse(@data))
     end

    it 'should allow prefetching' do
       @user.get(:loved_articles)
     end

     it 'should get articles' do
       @user.loved_articles[0][:artist].should == 'The Afters'
       @user.loved_articles[0][:description].blank?.should_not == true
     end

     it 'should parse the dates' do
       @user.loved_articles[0][:date].class.should == Time
     end
  end
  
  describe 'photos' do
    before(:each) do
      @data = open(Fixtures + 'user_photos.json').read
      @user.should_receive(:fetch).and_return(JSON.parse(@data))
    end
    
    it 'should allow prefetching' do
      @user.get(:photos)
    end
    
    it 'should get photos' do
      @user.photos[0][:title].should =~ /jpg/
      @user.photos[0][:url].should =~ /jpg/
      @user.photos[0][:width].class.should == Fixnum
      @user.photos[0][:height].class.should == Fixnum
    end
    
    it 'should parse the dates' do
      @user.photos[0][:date].class.should == Time
    end
  end
  
  describe 'videos' do    
    before(:each) do
      @data = open(Fixtures + 'user_videos.json').read
      @user.should_receive(:fetch).and_return(JSON.parse(@data))
    end
    
    it 'should allow prefetching' do
      @user.get(:videos)
    end
    
    it 'should get videos' do
      @user.videos[0][:location].should =~ /video/
      @user.videos[0][:info].should =~ /youtube/
      @user.videos[0][:thumb].should =~ /jpg/
    end
  end
  
  describe 'playlist' do
    before(:each) do
      @data = open(Fixtures + 'user_playlist.json').read
      @user.should_receive(:fetch).and_return(JSON.parse(@data))
    end
    
    it 'should allow prefetching' do
      @user.get(:playlist)
    end
    
    it 'should get playlist' do
      @user.playlist[0][:location] =~ /mp3/
    end
    
    it 'should respond to #tracks' do
      @user.get(:tracks)
      @user.tracks[0][:location] =~ /mp3/
    end
  end
end