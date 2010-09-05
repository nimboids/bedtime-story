Given %r/^we stub Twitter API calls$/ do
  reset_webmock
  stub_request :post, "http://api.twitter.com/statuses/update.json"
end

Given %r/^the Twitter API returns an error$/ do
  stub_request(:post, "http://api.twitter.com/statuses/update.json").to_return(:status => [401, "Unauthorized"])
end

Then %r/^"([^"]*)" should be posted to Twitter$/ do |text|
  WebMock.should have_requested(:post, "http://api.twitter.com/statuses/update.json").with do |request|
    request.body.should =~ /status=#{CGI.escape text}/
  end
end

When %r/^nothing should be posted to Twitter$/ do
  WebMock.should_not have_requested(:post, "http://api.twitter.com/statuses/update.json")
end
