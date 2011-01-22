class SchoolDaysConfigGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.file('school_days.rb', "config/initializers/school_days.rb")
      m.file('school_days.yml', "config/school_days.yml")
    end
  end

  protected
    def banner
      <<-EOS
Creates a school_days.yml config file and an initializer that loads the school days gem into your Rails app.

USAGE: #{$0} #{spec.name} name
EOS
    end
end