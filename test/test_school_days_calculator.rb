require File.dirname(__FILE__) + '/test_helper.rb'


class TestSchoolDaysCalculatorTest < Test::Unit::TestCase
  context "using a Date object" do
    context "when adding a school day" do
      should "move to tomorrow (if tomorrow is a school day)"
      should "move to Monday (if tomorrow is a weekend)"
      should "move forward one week when adding 5 school days"
      should "move forward onto an exceptional day"
      should "skip exceptional holidays"
      should "elegantly handle a situation where we go outside the school year"
    end

  end
end
