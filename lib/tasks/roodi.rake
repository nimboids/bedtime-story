require 'roodi'

desc 'Runs roodi design/convention checker'
task :roodi do
  roodi = Roodi::Core::Runner.new
  pattern = File.dirname(__FILE__) + '/../../app/**/*.rb'
  Dir.glob(pattern) {|file| roodi.check_file(file) }
  logfile = File.dirname(__FILE__) + '/../../log/roodi.txt'
  File.open logfile, 'w' do |f|
    roodi.errors.each {|error| f.puts error}
    f.puts "\nRoodi found #{roodi.errors.size} errors.\n"
  end
  puts File.read logfile
  raise 'Roodi found errors' unless roodi.errors.empty?
end
