require File.expand_path "../../spec_helper", __FILE__
require File.expand_path "../dummy_controller", __FILE__

describe ApplicationController do
  controller_name :dummy

  it "does not log passwords" do
    RAILS_DEFAULT_LOGGER.should_not_receive(:info).with /"secret"/
      post :dummy, :foo => {:password => "secret", :password_confirmation => "secret"}
  end

  it "assigns the finish date for the view" do
    get :dummy 
    assigns[:finish_date].should == ApplicationController::FINISH_DATE
  end

  describe "current user" do
    context "when there is no user session" do
      before do
        UserSession.stub(:find).and_return nil
      end

      it "is nil" do
        controller.current_user.should be_nil
      end
    end

    context "when there is a user session" do
      before do
        @user = mock User
        UserSession.stub(:find).and_return mock(UserSession, :record => @user)
      end

      it "is the user from the session" do
        controller.current_user.should == @user
      end

      it "is memoised" do
        controller.current_user
        UserSession.should_not_receive :find
        controller.current_user
      end
    end
  end
end
