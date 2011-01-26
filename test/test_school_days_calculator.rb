require File.dirname(__FILE__) + '/test_helper.rb'


class TestSchoolDaysCalculatorTest < Test::Unit::TestCase

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
