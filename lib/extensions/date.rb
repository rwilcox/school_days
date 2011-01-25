
require 'school_days/config'

module SchoolDays
  def school_day?
    # first, check the exceptional days and see if we can get a quick match
    return false if SchoolDays.config.holiday_exceptions.include? self
    return true if SchoolDays.config.included_day_exceptions.include? self

    # Now, the laborous part.

    # First, check to see if we are a week day
    weekday = [1,2,3,4,5].include?(self.wday)
    has_school = false

    if weekday
      has_school = true
    end

    has_school
  end

=begin
# TODO: implement me
  def school_night?
    
  end
=end
  def school_days_until(to_date)
    
  end
end

class Date
  include SchoolDays
end