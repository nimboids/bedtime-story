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
        flash[:notice].should == "Thank you!<br />Please check back soon to see whether your contribution was chosen."
      end
    end

    describe "when a failure" do
      before do
        @messages = %w(foo bar)
        @errors.stub(:full_messages).and_return @messages
        @errors.stub(:empty?).and_return false
      end

      it "redirects to the home page" do
        post :create
        response.should render_template("home/show.html.erb")
      end

      it "puts a message in the 'now' flash" do
        post :create
        response.flash[:errors].should == @messages
        flash[:errors].should be_nil
      end
    end
  end

  describe "RSS feed" do
    before do
      @contrib_1 = Factory :story_contribution, :text => "foo", :name => "fred", :approver_id => 1
      @contrib_2 = Factory :story_contribution, :text => "bar", :name => "bob", :approver_id => 1
      @story = [@contrib_1, @contrib_2]
      StoryContribution.stub(:approved).and_return @story
    end

    def do_get
      get :index, :format => "rss"
    end

    it "assigns all approved story contributions for the view" do
      do_get
      assigns[:story_contributions].should == @story
    end

    it "renders the RSS builder" do
      do_get
      response.should render_template "index.rss.builder"
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
        @contrib_1 = Factory :story_contribution
        @contrib_2 = Factory :story_contribution
        @id_to_approve = @contrib_1.id.to_s
        @edited_text = "edited text"
        StoryContribution.stub(:awaiting_approval).and_return [@contrib_1, @contrib_2]
        StoryContribution.stub :approve
        TwitterInterface.stub :update_status
      end

      def do_post
        post :approve, :story_contribution_id => @id_to_approve,
          "story_contribution_text_#{@id_to_approve}" => @edited_text
      end

      it "approves the correct contribution, with the edited text" do
        StoryContribution.should_receive(:approve).with @id_to_approve, @current_user, @edited_text
        do_post
      end

      it "invalidates the story cache for the home page" do
        controller.should_receive(:expire_fragment).with "story"
        do_post
      end

      context "when successful" do
        before do
          StoryContribution.stub(:approve).and_return true
        end

        it "posts the contribution to Twitter" do
          TwitterInterface.should_receive(:update_status).with @edited_text
          do_post
        end

        shared_examples_for "a successful update" do
          it "puts a status message in the flash" do
            do_post
            flash[:notice].should == "Contribution approved"
          end

          it "redirects to the home page" do
            do_post
            response.should redirect_to(root_url)
          end
        end

        context "when the Twitter update succeeds" do
          it_should_behave_like "a successful update"
        end

        context "when the Twitter update fails" do
          before do
            TwitterInterface.stub(:update_status).and_raise Twitter::TwitterError.new(nil)
          end

          it_should_behave_like "a successful update"

          it "puts a warning in the flash" do
            do_post
            flash[:errors].should == ["Warning: failed to post update to Twitter"]
          end
        end
      end

      context "when unsuccessful" do
        before do
          @messages = %w(foo bar)
          @errors = mock :errors, :full_messages => @messages
          contribution = mock_model StoryContribution, :errors => @errors
          StoryContribution.stub(:approve).and_raise ActiveRecord::RecordInvalid.new(contribution)
        end

        it "reassigns the edited contribution list for the view" do
          do_post
          assigns[:story_contributions].map{|c| [c.id, c.text]}.should == [
            [@contrib_1.id, "edited text"],
            [@contrib_2.id, @contrib_2.text]
          ]
        end

        it "puts the errors in the 'now' flash" do
          do_post
          response.flash[:errors].should == @messages
          flash[:errors].should be_nil
        end

        it "does not overwrite text of newly-appeared contributions" do
          @contrib_3 = Factory :story_contribution, :text => "I'm new!"
          StoryContribution.stub(:awaiting_approval).and_return [@contrib_1, @contrib_2, @contrib_3]
          do_post
          assigns[:story_contributions].find{|c| c == @contrib_3}.text.should == "I'm new!"
        end

        it "re-renders the admin page" do
          do_post
          response.should render_template("admin/index")
        end
      end
    end
  end

  describe "approved" do
    context "when not logged in" do
      before do
        controller.stub(:current_user).and_return nil
      end

      it "redirects to the login page" do
        get :approved
        response.should redirect_to new_user_session_url
      end
    end

    context "when logged in" do
      before do
        @current_user = mock :user
        controller.stub(:current_user).and_return @current_user
        @approved_contributions = [mock_model StoryContribution, :text => 'blah']
        StoryContribution.stub(:approved).and_return @approved_contributions
      end

      it "render the approved view" do
        get :approved
        response.should render_template('approved.html.erb')
      end

      it "assigns all the approved contributions for the view" do
        get :approved
        assigns[:story_contributions].should == @approved_contributions
      end
    end
  end

  describe "updating" do
    context "when not logged in" do
      before do
        controller.stub(:current_user).and_return nil
      end

      it "redirects to the login page" do
        put :update, :id => '1'
        response.should redirect_to new_user_session_url
      end
    end

    context "when logged in" do
      before do
        @current_user = mock :user
        controller.stub(:current_user).and_return @current_user
        @contrib = Factory :story_contribution
        @id = @contrib.id.to_s
        @edited_text = "edited text"
        StoryContribution.stub :update
      end

      def do_put
        put :update, :id => @id, :text =>  @edited_text
      end

      context "when successful" do
        it "puts a status message in the flash" do
          do_put
          flash[:notice].should == "Contribution updated"
        end

        it "redirects back to the approved contributions page" do
          do_put
          response.should redirect_to(approved_story_contributions_url)
        end

        it "invalidates the story cache for the home page" do
          controller.should_receive(:expire_fragment).with "story"
          do_put
        end
      end

      context "when unsuccessful" do
        before do
          @messages = %w(foo bar)
          @errors = mock :errors, :full_messages => @messages, :empty? => false
          contribution = mock_model StoryContribution, :errors => @errors, :update_attributes => false, :null_object => true
          StoryContribution.stub(:find).and_return contribution
        end

        it "puts a message in the 'now' flash" do
          do_put
          response.flash[:errors].should == @messages
          flash[:errors].should be_nil
        end

        it "renders the edit page" do
          do_put
          response.should render_template('edit.html.erb')
        end
      end
    end
  end
end
