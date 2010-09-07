require "timecop"

Given %r/^I freeze time to (\d+) days?, (\d+) hours?, (\d+) minutes? and (\d+) seconds? before the end time$/ do |days, hours, minutes, seconds|
  time = ApplicationController::FINISH_DATE - days.to_i.days - hours.to_i.hours - minutes.to_i.minutes - seconds.to_i.seconds
  puts "End time is #{ApplicationController::FINISH_DATE}"
  puts "Freezing to #{time}"
  Timecop.freeze time
end

When %r/^I wait for ([.\d]+) seconds?$/ do |seconds|
  sleep seconds.to_f
end
