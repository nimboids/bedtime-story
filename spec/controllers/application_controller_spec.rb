require File.expand_path "../../spec_helper", __FILE__
require File.expand_path "../dummy_controller", __FILE__

describe ApplicationController do
  controller_name :dummy

  it "does not log passwords" do
    RAILS_DEFAULT_LOGGER.should_not_receive(:info).with /"secret"/
      post :dummy, :foo => {:password => "secret", :password_confirmation => "secret"}
  end

  shared_examples_for "a 404 error" do
    it "returns a status of 404" do
      response.response_code.should == 404
    end

    it "renders the 404 template" do
      response.should render_template("/404")
    end
  end

  describe "when a routing error is raised" do
    before do
      get :raise_routing_error
    end

    it_should_behave_like "a 404 error"
  end

  describe "when an unknown action exception is raised" do
    before do
      get :raise_unknown_action
    end

    it_should_behave_like "a 404 error"
  end

  describe "when a missing template exception is raised" do
    before do
      get :raise_missing_template
    end

    it_should_behave_like "a 404 error"
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
