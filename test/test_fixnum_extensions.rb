require File.dirname(__FILE__) + '/test_helper.rb'


class TestFixnumExtension < Test::Unit::TestCase

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
      date = Date.civil(2012, 5, 11)
      assert_equal( date + 1, 1.school_day.after(date) )
    end

    should "skip exceptional holidays" do
      date = Date.civil(2012, 4, 30) # is a Tuesday, but May 1 is a holiday
      assert_equal( (date + 2).to_s, (1.school_day.after(date)).to_s )
      # so we expect May 2
    end

    should "move to the next session if we have multiple sessions" do
      date = Date.civil(2011, 12, 12) # a Monday before semester break
      assert_equal( Date.civil(2012, 1, 17), 5.school_days.after(date) )
    end

    should "elegantly handle a situation where we go outside the school year" do
      date = Date.civil(2012, 5, 14)
      assert_raise(SchoolDays::DateNotInSchoolCalendar) { 1.school_day.after(date) }
    end
  end

  context "when subtracting a school day" do
    setup do
      SchoolDays.config.load( fixture_path() + "/double_session_test.yml" )
    end

    should "move to yesterday (if yesterday is a school day)" do
      date = Date.civil(2011, 10, 18) # a Tuesday
      assert_equal( date - 1, 1.school_day.before(date) )
    end

    should "move to Friday (if yesterday is a weekend)" do
      date = Date.civil(2011, 10, 17) # a Monday
      assert_equal( date - 3, 1.school_day.before(date) )
    end

    should "move back one week when adding 5 school days" do
      date = Date.civil(2011, 10, 21) #a Friday
      assert_equal( date - 7, 5.school_days.before(date) )
    end

    should "move backwards onto an exceptional day" do
      date = Date.civil(2012, 5, 14)

      assert date.school_day?
      assert_equal( Date.civil(2012, 5, 12), 1.school_day.before(date) )

    end

    should "skip exceptional holidays" do
      date = Date.civil(2012, 1, 25)
      assert_equal( Date.civil(2012, 1, 20), 2.school_days.before(date) )
    end

    should "move to the previous session if we have multiple sessions" do
      date = Date.civil(2012, 1, 16)
      assert_equal( Date.civil(2011, 12, 14), 2.school_days.before(date) )
    end

    should "elegantly handle a situation where we go outside the school year" do
      date = Date.civil(2011, 8, 26)
      assert_raise(SchoolDays::DateNotInSchoolCalendar) { 1.school_day.before(date) }
    end

  end

end

