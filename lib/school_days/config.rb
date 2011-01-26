require 'singleton'
require 'yaml'
require 'date'

module SchoolDays

  # controls the behavior of this gem.  Currently this gem only supports
  # loading information from a YAML file (TODO: implement programatic ways)
  # ... well, you could do it, but I don't care about that code path yet...
  class ConfigBase
    attr_accessor :school_sessions
    attr_accessor :holiday_exceptions
    attr_accessor :included_day_exceptions

    def reset
      self.school_sessions = {}
      self.holiday_exceptions = []
      self.included_day_exceptions = []
    end

    def load(filename)
      reset
      data = YAML::load(File.open(filename))
      sessions = data["school_days"]["school_sessions"]

      self.school_sessions = sessions.collect do |session_name, session_value|
        if session_value["start_date"].nil? || session_value["end_date"].nil?
          raise "start_date or end_date is blank for #{session_name} in #{filename}"
        end

        {:start_date => Date.parse(session_value["start_date"]),
          :end_date => Date.parse(session_value["end_date"])}
      end
      
      data["school_days"]["exceptions"]["holidays"].each do |holiday|
        self.holiday_exceptions << Date.parse(holiday)
      end

      data["school_days"]["exceptions"]["included_days"].each do |extra_day|
        self.included_day_exceptions << Date.parse(extra_day)
      end
    end

    def school_year_start
      res = self.school_sessions.min do |a, b|
        a[:start_date] <=> b[:start_date]
      end
      res[:start_date]
    end

    def school_year_end
      res = self.school_sessions.max do |a, b|
        a[:end_date] <=> b[:end_date]
      end
      res[:end_date]
    end
  end

  class Config < ConfigBase
    include Singleton
  end

  def self.config
    Config.instance
  end
end
