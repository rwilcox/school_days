require File.dirname(__FILE__) + '/test_helper.rb'

class TestConfig < Test::Unit::TestCase
  should "load a file with one session with no errors" do
    conf = SchoolDays::ConfigBase.new
    assert_nothing_raised(Exception) {  conf.load( fixture_path() + "/simple_test.yml" )   }
  end

  should "load a file with two sessions correctly" do
    conf = SchoolDays::ConfigBase.new
    assert_nothing_raised(Exception) {  conf.load( fixture_path() + "/double_session_test.yml" )  }
    assert conf.sessions.length == 2
  end

  context "holiday exceptions" do
    should "only include listed holiday exceptions, as Ruby Date objects" do
      conf = SchoolDays::ConfigBase.new
      conf.load( fixture_path() + "/simple_test.yml" )

      assert_contains( conf.holiday_exceptions, Time.parse("Jan 01, 2010") )
      assert_does_not_contain( conf.holiday_exceptions, Time.parse("Jan 02, 2010") )
    end
  end

  context "exceptional included days" do
    should "only include exceptional included days, as Ruby date objects" do
      conf = SchoolDays::ConfigBase.new
      conf.load( fixture_path() + "/simple_test.yml" )

      assert_contains( conf.included_day_exceptions, Time.parse("May 29, 2011") )
      assert_does_not_contain( conf.included_day_exceptions, Time.parse("May 31, 2011") )
    end
  end

end