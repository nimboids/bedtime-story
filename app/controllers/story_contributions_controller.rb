class StoryContributionsController < InheritedResources::Base
  before_filter :authenticate, :only => :approve

  def create
    create! do |success, failure|
      success.html do
        flash[:notice] = "Thank you! Your contribution is awaiting moderation"
        redirect_to root_url
      end
      failure.html do
        flash[:errors] = @story_contribution.errors.full_messages
        render :template => "/home/show"
      end
    end
  end

  def approve
    selected_id = params[:story_contribution_id]
    edited_text = params["story_contribution_text_#{selected_id}"]
    StoryContribution.approve selected_id, current_user, edited_text
    redirect_to :root
  rescue ActiveRecord::RecordInvalid => e
    @story_contributions = StoryContribution.awaiting_approval
    @story_contributions.each do |contribution|
      edited_text = params["story_contribution_text_#{contribution.id}"]
      contribution.text = edited_text if edited_text
    end
    flash.now[:errors] = e.record.errors.full_messages
    render :template => "/admin/index"
  end
end
