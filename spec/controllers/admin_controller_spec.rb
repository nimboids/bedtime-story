require File.expand_path "../../spec_helper", __FILE__

describe AdminController do
  describe "index" do
    context "when not logged in" do
      before do
        controller.stub(:current_user).and_return nil
      end

      it "redirects to the login page" do
        get :index
        response.should redirect_to new_user_session_url
      end
    end

    context "when logged in" do
      before do
        controller.stub(:current_user).and_return stub(User)
        @contributions = mock :contributions
        StoryContribution.stub(:awaiting_approval).and_return @contributions
      end

      it "retrieves a list of unapproved contributions" do
        get :index
        assigns[:story_contributions].should == @contributions
      end

      it "renders the index template" do
        get :index
        response.should render_template("index")
      end
    end
  end
end
