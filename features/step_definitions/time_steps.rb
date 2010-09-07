require "timecop"

World ApplicationHelper

Given %r/^I freeze time to (\d+) days?, (\d+) hours?, (\d+) minutes? and (\d+) seconds? before the end time$/ do |days, hours, minutes, seconds|
  time = finish_date - days.to_i.days - hours.to_i.hours - minutes.to_i.minutes - seconds.to_i.seconds
  Timecop.freeze time
end

When %r/^I wait for ([.\d]+) seconds?$/ do |seconds|
  sleep seconds.to_f
end
