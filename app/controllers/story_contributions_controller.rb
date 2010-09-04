class StoryContributionsController < InheritedResources::Base
  before_filter :authenticate, :only => :approve

  def create
    create! do |success, failure|
      success.html do
        flash[:notice] = "Thank you! Your contribution is awaiting moderation"
        redirect_to root_url
      end
      failure.html do
        flash[:errors] = @story_contribution.errors.full_messages.join("<br />")
        render :template => '/home/show'
      end
    end
  end

  def approve
    selected_id = params[:story_contribution_id]
    edited_text = params["story_contribution_text_#{selected_id}"]
    StoryContribution.approve selected_id, current_user, edited_text
    redirect_to admin_index_url
  end
end
