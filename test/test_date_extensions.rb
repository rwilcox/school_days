require File.dirname(__FILE__) + '/test_helper.rb'


class TestDateExtensions < Test::Unit::TestCase

  context "Date instances" do
    setup do
      SchoolDays.config.load( fixture_path() + "/simple_test.yml" )
    end

    should "Date should respond to school_day?" do
      assert_nothing_raised(Exception) { Date.today.school_day? }
    end

    should "return true for school_day if the day is a weekday" do
      days = (24..28).to_a # In January 2011 these are all weedays
      days.each do |day|
        date = Date.civil(2011, 01, day)
        assert date.school_day?
      end
    end

    should "return false for school_day? if the day is a weekend"
    should "return true for school_day? if the day is a weekday"
    should "return false for school_day? if the day is flagged as a holiday"
    should "return true for school_day? if a normally off day is flagged as an included day "

    context "when looking at a single school session" do
      setup do

      end

      should "return false for school_day? if the date is outside the session"
      should "return true for school_day? if the date is inside the session"
    end

    context "when looking at multiple school sessions" do
      setup do

      end

      should "return false for school_day? if the date is outside ALL of the sessions"
      should "return true for school_day? if the date is outside one session, but inside another"
    end
    
  end
  
end
