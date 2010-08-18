require File.dirname(__FILE__) + '/../spec_helper'

describe NimbusLogger do
  describe 'logging a message' do
    before do
      @file = stub('file').as_null_object
      @file.stub! :write
      @file.stub! :close
      @logger = NimbusLogger.new @file
      @progname = 'prog'
      @message = "hello world"
      @now = Time.now
      Time.stub!(:now).and_return @now
    end

    it 'should put the date in UTC, the progname and severity in the log message' do
      @file.should_receive(:write).with "#{@now.utc.xmlschema}   DEBUG -- #{@progname}: #{@message}\n"
      @file.should_receive(:write).with "#{@now.utc.xmlschema}    INFO -- #{@progname}: #{@message}\n"
      @logger.debug @message, @progname
      @logger.info @message, @progname
    end
  end
end
