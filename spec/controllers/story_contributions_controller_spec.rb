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
        @errors.stub(:full_messages).and_return %w(foo bar)
        @errors.stub(:empty?).and_return false
      end

      it "redirects to the home page" do
        post :create
        response.should render_template("home/show.html.erb")
      end

      it "puts a message in the flash" do
        post :create
        flash[:errors].should == "foo<br />bar"
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
        @current_user = mock :user
        controller.stub(:current_user).and_return @current_user
        @id_to_approve = "123"
        @edited_text = "edited text"
        StoryContribution.stub :approve
      end

      def do_post
        post :approve, :story_contribution_id => @id_to_approve,
          "story_contribution_text_#{@id_to_approve}" => @edited_text
      end

      it "approves the correct contribution, with the edited text" do
        StoryContribution.should_receive(:approve).with @id_to_approve, @current_user, @edited_text
        do_post
      end

      it "redirects to the admin page" do
        do_post
        response.should redirect_to(admin_index_url)
      end
    end
  end
end
