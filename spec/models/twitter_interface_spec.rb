require 'spec_helper'

describe TwitterInterface do
  describe "updating status" do
    before do
      ENV["TWITTER_CONSUMER_KEY"] = "cc"
      ENV["TWITTER_CONSUMER_SECRET"] = "cs"
      ENV["TWITTER_ACCESS_TOKEN"] = "at"
      ENV["TWITTER_ACCESS_SECRET"] = "as"
      @auth = stub :auth, :authorize_from_access => true
      Twitter::OAuth.stub(:new).with(ENV["TWITTER_CONSUMER_KEY"], ENV["TWITTER_CONSUMER_SECRET"]).and_return @auth
      @client = stub :client, :update => true
      Twitter::Base.stub(:new).with(@auth).and_return @client
    end

    def do_update
      TwitterInterface.update_status "foo"
    end

    it "authenticates using oauth" do
      @auth.should_receive(:authorize_from_access).with(ENV["TWITTER_ACCESS_TOKEN"], ENV["TWITTER_ACCESS_SECRET"])
      do_update
    end

    it "posts the update" do
      @client.should_receive(:update).with "foo"
      do_update
    end
  end
end
