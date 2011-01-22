require 'singleton'

module SchoolDays

  # controls the behavior of this gem.  Currently this gem only supports
  # loading information from a YAML file (TODO: implement programatic ways)
  class ConfigBase
    attr_accessor :sessions
    attr_accessor :holiday_exceptions
    attr_accessor :included_day_exceptions

    def reset
      self.sessions = {}
      self.holiday_exceptions = []
      self.included_day_exceptions = []
    end

    def load(filename)
      reset
      data = YAML::load(File.open(filename))
      self.sessions = data["school_days"]["school_sessions"]

      data["school_days"]["exceptions"]["holidays"].each do |holiday|
        self.holiday_exceptions <<
          ( Time.zone ? Time.zone.parse(holiday) : Time.parse(holiday) )
      end

      data["school_days"]["exceptions"]["included_days"].each do |extra_day|
        self.included_day_exceptions <<
          ( Time.zone ? Time.zone.parse(extra_day) : Time.parse(extra_day) )
      end
    end
  end

  class Config < ConfigBase
    include Singleton
  end
end
