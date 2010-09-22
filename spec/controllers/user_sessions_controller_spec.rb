require File.expand_path "../../spec_helper", __FILE__

describe UserSessionsController do
  # need to test with integrated views here for inherited resources
  integrate_views

  it "is an inherited resources controller" do
    controller.should be_a InheritedResources::Base
  end

  describe "creating" do
    before do
      @user_session = mock UserSession, :id => 123, :null_object => true
      UserSession.stub(:new).and_return @user_session
      @params = {:login => "fred", :password => "secret"}.with_indifferent_access
    end

    def do_post
      post :create, :user_session => @params
    end

    it "assigns a new user session for the view" do
      do_post
      assigns[:user_session].should == @user_session
    end

    context "when login is successful" do
      before do
        @user_session.stub(:save).and_return true
      end

      it "redirects to the admin page" do
        do_post
        response.should redirect_to admin_index_url
      end
    end

    context "when login fails" do
      before do
        @user_session.stub(:save).and_return false
      end

      it "re-renders the login page" do
        do_post
        response.should render_template("new")
      end
    end
  end

  describe "destroying" do
    before do
      @session = mock UserSession, :null_object => true
      UserSession.stub(:find).and_return @session
    end

    def do_delete
      delete :destroy
    end

    it "destroys the current user session" do
      @session.should_receive :destroy
      do_delete
    end

    it "redirects to the home page" do
      do_delete
      response.should redirect_to root_url
    end
  end
end
