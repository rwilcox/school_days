require 'config'


module SchoolDays
  class SchoolDaysCalculator
    def initialize(days)
      @days = days
    end

    def after(time = Time.now)
      # 2.school_days.after(tuesday)
      date = time.to_date
      @days.times do
        begin
          date = date + 1
        end until date.school_day?
      end
    end
    alias_method :from_now, :after

    def before(time = Time.now)
      
    end
    alias_method :until, :before

  end
end