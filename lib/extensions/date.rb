

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

      # ok, now check to see if this weekday is in the school sessions
      has_school = SchoolDays.config.school_sessions.any? do |current_session|
        current_session[:start_date] < self && current_session[:end_date] > self
      end
    end

    has_school
  end

  def school_night?
    (self + 1).school_day?
  end
end

class Date
  include SchoolDays
end