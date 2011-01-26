require File.dirname(__FILE__) + '/test_helper.rb'


class TestSchoolDaysCalculatorTest < Test::Unit::TestCase
  context "using a Date object" do
    context "when adding a school day" do
      setup do
        SchoolDays.config.load( fixture_path() + "/double_session_test.yml" )
      end

      should "move to tomorrow (if tomorrow is a school day)" do
        date = Date.civil(2011, 10, 18) # a Tuesday
        assert_equal( date + 1, 1.school_day.after(date) )
      end

      should "move to Monday (if tomorrow is a weekend)"
      should "move forward one week when adding 5 school days"
      should "move forward onto an exceptional day"
      should "skip exceptional holidays"

      should "move to the next session if we have multiple sessions"
      should "elegantly handle a situation where we go outside the school year"
    end

  end
end
