require "spec_helper"

describe StoryContributionsController do
  # need to test with integrated views here for inherited resources
  integrate_views

  it "should be an inherited resources controller" do
    controller.should be_a InheritedResources::Base
  end

  describe "creating" do
    before do
      @errors = ActiveRecord::Errors.new @story_contribution
      @story_contribution = mock_model StoryContribution, :errors => @errors, :null_object => true
      StoryContribution.stub(:new).and_return @story_contribution
    end

    describe "when successful" do
      before do
        @story_contribution.stub(:save).and_return(true)
      end

      it "redirects to the home page" do
        post :create
        response.should redirect_to root_url
      end

      it "puts a message in the flash" do
        post :create
        flash[:notice].should == "Thank you! Your contribution is awaiting moderation"
      end
    end

    describe "when a failure" do
      before do
        @messages = stub :messages
        @errors.stub(:full_messages).and_return @messages
        @errors.stub(:empty?).and_return false
      end

      it "redirects to the home page" do
        post :create
        response.should render_template("home/show.html.erb")
      end

      it "puts a message in the flash" do
        post :create
        flash[:errors].should == @messages
      end
    end
  end

  describe "approving" do
    context "when not logged in" do
      before do
        controller.stub(:current_user).and_return nil
      end

      it "redirects to the login page" do
        post :approve
        response.should redirect_to new_user_session_url
      end
    end

    context "when logged in" do
      before do
        @current_user = Factory :user
        controller.stub(:current_user).and_return @current_user
        StoryContribution.destroy_all
        @contrib_1 = Factory :story_contribution
        @contrib_2 = Factory :story_contribution
        @contrib_3 = Factory :story_contribution
      end

      def do_post
        post :approve, :story_contribution_id => @contrib_2.id
      end

      it "marks the contribution as approved by the current user" do
        do_post
        @contrib_2.reload.approver.should == @current_user
      end

      it "marks all other contribution awaiting approval as rejected" do
        do_post
        StoryContribution.awaiting_approval.should be_empty
      end

      it "redirects to the admin page" do
        do_post
        response.should redirect_to(admin_index_url)
      end
    end
  end
end
