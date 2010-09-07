require File.expand_path "../../spec_helper", __FILE__

describe HomeController do
  integrate_views

  describe "show" do
    it "caches approved story contributions in the view" do
      ActionController::Base.perform_caching = true
      StoryContribution.should_receive(:approved).once.and_return []
      2.times {get :show}
    end

    it "renders the show template" do
      StoryContribution.stub(:approved).and_return []
      get :show
      response.should render_template("show")
    end
  end
end
