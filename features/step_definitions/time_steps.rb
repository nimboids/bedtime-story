require "timecop"

World ApplicationHelper

Given %r/^it is (\d+):(\d+) GMT$/ do |hours, minutes|
  now = (finish_date - 10.days)
  time = Time.gm now.year, now.month, now.day, hours, minutes, 0
  Timecop.freeze time
end

Given %r/^it is (\d+) days?, (\d+) hours?, (\d+) minutes? and (\d+) seconds? (before|after) the end time$/ do |days, hours, minutes, seconds, direction|
  offset = days.to_i.days + hours.to_i.hours + minutes.to_i.minutes + seconds.to_i.seconds
  time = (direction == "before") ? finish_date - offset : finish_date + offset
  Timecop.freeze time
end

When %r/^I wait for ([.\d]+) seconds?$/ do |seconds|
  sleep seconds.to_f
end
