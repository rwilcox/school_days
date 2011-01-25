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

    should "return false for school_day? if the day is a weekend" do
      weekend = Date.civil(2011, 01, 29)
      assert !weekend.school_day?
    end

    should "return true if the day is a school night" do
      date = Date.civil(2011, 1, 27) #Thursday
      assert date.school_night?
    end

    should "return false if the day is not a school night" do
      date = Date.civil(2011, 1, 28) #Friday
      assert !date.school_night?
    end

    should "return true before an exceptional included day" do
      date = Date.civil(2011, 5, 28)
      assert date.school_night?
    end

    should "return false for school_day? if the day is flagged as a holiday" do
      days = (24..28).to_a # In January 2011 these are all weedays
      days.each do |day|
        date = Date.civil(2011, 5, 31) # our simple_test.yml defines this as a holiday
        # May 31, 2011 is a Tuesday.

        assert !date.school_day?
      end
    end

    should "return true for school_day? if a normally off day is flagged as an included day" do
      date = Date.civil(2011, 5, 29) # while it is a Sunday in 2011, it's on our list
      # of exceptional included days, so it must be included

      assert date.school_day?
    end

    context "when looking at a single school session" do
      setup do

      end

      should "return false for school_day? if the date is outside the session (and not in exceptional included days)" do
        date = Date.civil(2011, 6, 2) # June 2 is a Thursday in 2011... but it's also outside the school session
        assert !date.school_day?(), "Day outside school session still thinks its a school day"
      end

      should "return true for school_day? if the date is inside the session (and not in exceptional included days)" do
        date = Date.civil(2010, 10, 18)
        assert date.school_day?
      end
    end

    context "when looking at multiple school sessions" do
      setup do
        SchoolDays.config.load( fixture_path() + "/double_session_test.yml" )
      end

      should "return false for school_day? if a weekday is is outside ALL of the sessions (and not in exceptional included days)" do
        date = Date.civil(2012, 6, 2) # June 2 is a Thursday in 2011... but it's also outside the school session
        assert !date.school_day?(), "Day outside school session still thinks its a school day"
      end

      should "return false for school_day if the weekday is between school sessions" do
        date = Date.civil(2012, 12, 30) # Dec 30 is a Friday in 2011... but it's in between two school sessions
        assert !date.school_day?(), "Day between school sessions still thinks its a school day"
      end

      should "return false for school_day? if a weekend is is outside ALL of the sessions (and not in exceptional included days)" do
        date = Date.civil(2012, 5, 31) # a thursday in 2012
        assert !date.school_day?
      end
      
      should "return true for school_day? if the date is outside one session, but inside another"
    end
    
  end
  
end
