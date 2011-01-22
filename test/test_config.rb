require File.dirname(__FILE__) + '/test_helper.rb'

class TestConfig < Test::Unit::TestCase
  should "load a file with one session with no errors" do
    conf = SchoolDays::ConfigBase.new
    assert_nothing_raised(Exception) { conf.load( fixture_path() + "/simple_test.yml" )  }
    
  end

  should "load a file with two sessions correctly" do
    
  end

  context "holiday exceptions" do
    should "only include listed holiday exceptions, as Ruby Date objects" do
      
    end
  end

  context "exceptional included days" do
    should "only include exceptional included days, as Ruby date objects" do
      
    end
  end

end