require "timecop"

World ApplicationHelper

Given %r/^it is (\d+):(\d+) GMT$/ do |hours, minutes|
  now = Time.now.getgm
  time = Time.gm now.year, now.month, now.day, hours, minutes, 0
  Timecop.freeze time
end

Given %r/^it is (\d+) days?, (\d+) hours?, (\d+) minutes? and (\d+) seconds? before the end time$/ do |days, hours, minutes, seconds|
  time = finish_date - days.to_i.days - hours.to_i.hours - minutes.to_i.minutes - seconds.to_i.seconds
  Timecop.freeze time
end

When %r/^I wait for ([.\d]+) seconds?$/ do |seconds|
  sleep seconds.to_f
end
