require File.dirname(__FILE__) + '/spec_helper.rb'

module BlankHelpers
  class EmptyTrue
    def empty?() true; end
  end

  class EmptyFalse
    def empty?() false; end
  end
  
  BLANK = [ EmptyTrue.new, nil, false, '', '   ', "  \n\t  \r ", [], {} ]
  NOT   = [ EmptyFalse.new, Object.new, true, 0, 1, 'a', [nil], { nil => 0 } ]
end


describe 'Idiomag helpers' do
  describe 'blank' do
    it 'should evaluate correctly' do
      BlankHelpers::BLANK.each { |v| v.blank?.should == true}
      BlankHelpers::NOT.each { |v| v.blank?.should == false}
    end
  end
end