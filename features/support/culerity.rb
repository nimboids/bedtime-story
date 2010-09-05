# Bundler 1.0 hack: http://github.com/carlhuda/bundler/issues/issue/478
if ENV['RUBYOPT']
  ENV['RUBYOPT'] = ENV['RUBYOPT'].gsub(%r{-r\s*bundler/setup}, '')
end

Before("@javascript") do |scenario|
  WebMock.allow_net_connect!
end
