require File.expand_path "../../spec_helper", __FILE__

describe HomeController do
  describe "show" do
    before do
      @story_contributions = mock
      StoryContribution.stub(:all).and_return @story_contributions
    end

    it "retrieves the story so far" do
      get :show
      assigns[:story_contributions].should == @story_contributions
    end

    it "renders the show template" do
      get :show
      response.should render_template("show")
    end
  end
end
