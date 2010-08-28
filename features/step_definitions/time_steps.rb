require "timecop"

Given %r/^I freeze time to (\d+)\/(\d+)\/(\d+) (\d+):(\d+):(\d+)$/ do |day, month, year, hour, minutes, seconds|
  Timecop.freeze(Time.local(year, month, day, hour, minutes, seconds))
end
