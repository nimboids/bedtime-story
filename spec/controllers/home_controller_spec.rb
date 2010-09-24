require File.expand_path "../../spec_helper", __FILE__

describe HomeController do
  integrate_views

  describe "show" do
    it "caches approved story contributions in the view" do
      ActionController::Base.perform_caching = true
      StoryContribution.should_receive(:approved).once.and_return []
      2.times {get :show}
    end

    it "allows the page to be cached for up to a second" do
      get :show
      response.headers["Cache-Control"].should == "public, max-age=1"
    end

    it "assigns a new story contribution for the view" do
      story_contribution = StoryContribution.new
      StoryContribution.stub(:new).and_return story_contribution
      get :show
      assigns[:story_contribution].should == story_contribution
    end

    it "renders the show template" do
      StoryContribution.stub(:approved).and_return []
      get :show
      response.should render_template("show")
    end
  end
end
