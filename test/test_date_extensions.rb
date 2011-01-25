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

      should "return false for school_day? if the date is outside the session (and not in exceptional included days)"
      should "return true for school_day? if the date is inside the session (and not in exceptional included days)"
    end

    context "when looking at multiple school sessions" do
      setup do

      end

      should "return false for school_day? if a weekday is is outside ALL of the sessions (and not in exceptional included days)"
      should "return false for school_day? if a weekend is is outside ALL of the sessions (and not in exceptional included days)"
      should "return true for school_day? if the date is outside one session, but inside another"
    end
    
  end
  
end
