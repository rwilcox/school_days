
require 'school_days/config'

module SchoolDays
  def school_day?
    # first, check to see if we are a week day
    weekday = [1,2,3,4,5].include?(self.wday)
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