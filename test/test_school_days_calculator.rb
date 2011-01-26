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

      should "move to Monday (if tomorrow is a weekend)" do
        date = Date.civil(2011, 10, 21) # a Friday
        assert_equal( date + 3, 1.school_days.after(date) )
      end

      should "move forward one week when adding 5 school days" do
        date = Date.civil(2011, 10, 17) # a Monday
        assert_equal( date + 7, 5.school_days.after(date) )
      end

      should "move forward onto an exceptional day" do
        date = Date.civil(2011, 5, 28)
        assert_equal( date + 1, 1.school_day.after(date) )
      end

      should "skip exceptional holidays" do
        date = Date.civil(2012, 4, 30) # is a Tuesday, but May 1 is a holiday
        assert_equal( (date + 2).to_s, (1.school_day.after(date)).to_s )
        # so we expect May 2
      end

      should "move to the next session if we have multiple sessions" do
        date = Date.civil(2011, 12, 12) # a Monday before semester break
        assert_equal( Date.civil(2012, 1, 18), 5.school_days.after(date) )
      end

      should "elegantly handle a situation where we go outside the school year" do
        date = Date.civil(2012, 5, 14)
        assert_raise(SchoolDays::DateNotInSchoolCalendar) { 1.school_day.after(date) }
      end
    end
  end


  context "identifying if a date is in the range of the whole school year" do
    context "with a single session" do
      setup do
        SchoolDays.config.load( fixture_path() + "/simple_test.yml" )
      end

      should "return true when it falls in the school year" do
        date = Date.civil(2010, 9, 9) # a Thursday
        calc = SchoolDays::Calculator.new(nil)

        assert calc.is_in_school_year?(date)
      end

      should "return false when it falls OUTSIDE of the school year" do
        date = Date.civil(2011, 6, 2) # a friday
        calc = SchoolDays::Calculator.new(nil)

        assert !calc.is_in_school_year?(date)
      end
    end

    context "with many sessions" do
      setup do
        SchoolDays.config.load( fixture_path() + "/double_session_test.yml" )
      end

      should "return true when it falls in the school year" do
        date = Date.civil(2011, 9, 9) # a Friday
        calc = SchoolDays::Calculator.new(nil)

        assert calc.is_in_school_year?(date)

        date = Date.civil(2012, 1, 16)
        assert calc.is_in_school_year?(date)
      end

      should "return false when it falls OUTSIDE of the school year" do
        date = Date.civil(2012, 5, 31) # a Thursday
        calc = SchoolDays::Calculator.new(nil)

        assert !calc.is_in_school_year?(date)
      end
    end
  end
end
