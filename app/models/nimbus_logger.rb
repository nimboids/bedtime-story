require 'active_support'

class NimbusLogger < ActiveSupport::BufferedLogger
  severity_names = ActiveSupport::BufferedLogger::Severity.constants
  max_length = severity_names.map(&:length).max
  SEVERITIES = Hash[*severity_names.map do |c|
    [ActiveSupport::BufferedLogger::Severity.const_get(c), "%#{max_length}s" % c]
  end.flatten]

  def add_with_formatting(severity, message = nil, progname = nil, &block)
    formatted_message = "#{Time.now.utc.xmlschema} #{SEVERITIES[severity]} -- #{progname}: #{message}\n"
    add_without_formatting severity, formatted_message, progname, &block
  end

  alias_method_chain :add, :formatting
end
