require File.expand_path "../../spec_helper", __FILE__

describe UserSessionsController do
  # need to test with integrated views here for inherited resources
  integrate_views

  it "should be an inherited resources controller" do
    controller.should be_a InheritedResources::Base
  end

  describe "create" do
    it "attempts to log the user in"

    context "when login is successful" do
      it "redirects to the admin page" do
        post :create
        response.should redirect_to admin_index_url
      end
    end

    context "when login fails" do
    end
  end
end
