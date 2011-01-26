
module SchoolDays
  class SchoolDaysCalculator
    def initialize(days)
      @days = days
    end

    def after(time = Time.now)
      # example: 2.school_days.after(tuesday)
      date = time
      date = time.to_date if time.is_a?(Time)

      @days.times do
        begin
          date = date + 1
        end until date.school_day?
      end
      date
    end
    alias_method :from_now, :after

    def before(time = Time.now)
      
    end
    alias_method :until, :before

  end
end