require File.expand_path "../../spec_helper", __FILE__

describe PagesController do
  describe "show" do
    before do
      @story_contributions = mock
      StoryContribution.stub(:all).and_return @story_contributions
    end

    it "retrieves the story so far" do
      get :show, :page => "home"
      assigns[:story_contributions].should == @story_contributions
    end

    it "should do the above in a different controller"

    it "renders the template given in 'page'" do
      get :show, :page => "foo"
      response.should render_template("foo")
    end
  end
end
