begin
  require 'spec/rake/verify_rcov'

  namespace :spec do
    desc "Check that we have 100% coverage"
    RCov::VerifyTask.new(:verify_rcov) do |t|
      t.threshold = 100.0
      t.index_html = 'coverage/index.html'
    end
  end
rescue MissingSourceFile
  STDERR.puts 'Warning: rspec gem not installed.'
end
