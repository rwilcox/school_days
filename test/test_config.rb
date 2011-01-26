require File.dirname(__FILE__) + '/test_helper.rb'

class TestConfig < Test::Unit::TestCase
  should "load a file with one session with no errors" do
    conf = SchoolDays::ConfigBase.new
    assert_nothing_raised(Exception) {  conf.load( fixture_path() + "/simple_test.yml" )   }
  end

  should "load a file with two sessions correctly" do
    conf = SchoolDays::ConfigBase.new
    assert_nothing_raised(Exception) {  conf.load( fixture_path() + "/double_session_test.yml" )  }
    assert conf.school_sessions.length == 2
  end

  context "holiday exceptions" do
    should "only include listed holiday exceptions, as Ruby Date objects" do
      conf = SchoolDays::ConfigBase.new
      conf.load( fixture_path() + "/simple_test.yml" )

      assert_contains( conf.holiday_exceptions, Date.parse("Jan 01, 2011") )
      assert_does_not_contain( conf.holiday_exceptions, Date.parse("Jan 02, 2011") )
    end
  end

  context "exceptional included days" do
    should "only include exceptional included days, as Ruby date objects" do
      conf = SchoolDays::ConfigBase.new
      conf.load( fixture_path() + "/simple_test.yml" )

      assert_contains( conf.included_day_exceptions, Date.parse("May 29, 2011") )
      assert_does_not_contain( conf.included_day_exceptions, Date.parse("May 31, 2011") )
    end
  end

  context "when loading an invalid config file" do
    should "throw a Runtime error when we're missing start or end dates for a session" do
      conf = SchoolDays::ConfigBase.new
      assert_raise(RuntimeError) {  conf.load( fixture_path() + "/invalid_config_test.yml" )   }
    end
  end

  context "when loading a file with one session" do
    should "be able to find the start date"
    should "be able to find the end date"
  end

  context "when loading a file with multiple sessions" do
    should "be able to find the first start date"
    should "be able to find the last end date"
  end
end