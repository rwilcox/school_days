# hook into fixnum so we can say things like:
#  5.school_days.from_now
#  7.school_days.ago

module SchoolDays
  module FixnumExtensions
    def school_days
      SchoolDays::Calculator.new(self)
    end
    alias :school_day :school_days

  end
end

class Fixnum
  include SchoolDays::FixnumExtensions
end
  