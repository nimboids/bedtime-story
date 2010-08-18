task :stats => "statsetup"

task :statsetup do
  require 'code_statistics'
  ::STATS_DIRECTORIES << ['Features', 'features']
  ::CodeStatistics::TEST_TYPES << 'Features'
end

desc 'Outputs project stats to log/stats.txt'
task :report_stats do
  orig_stdout = $stdout
  orig_stderr = $stderr
  $stdout = File.new('log/stats.txt', 'w')
  $stderr = $stdout
  Rake::Task['stats'].invoke
  $stdout = orig_stdout
  $stderr = orig_stderr
end
