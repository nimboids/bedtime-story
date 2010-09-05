require "twitter"

class TwitterInterface
  def self.update_status text
    auth = Twitter::OAuth.new ENV["TWITTER_CONSUMER_KEY"], ENV["TWITTER_CONSUMER_SECRET"]
    auth.authorize_from_access ENV["TWITTER_ACCESS_TOKEN"], ENV["TWITTER_ACCESS_SECRET"]
    client = Twitter::Base.new(auth)
    client.update text
  end
end
