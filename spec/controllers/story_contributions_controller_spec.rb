require 'spec_helper'

describe StoryContributionsController do
  # need to test with integrated views here for inherited resources
  integrate_views

  it "should be an inherited resources controller" do
    controller.should be_a InheritedResources::Base
  end

  describe "creating" do
    it "redirects to the home page" do
      post :create
      response.should redirect_to root_url
    end
  end
end
