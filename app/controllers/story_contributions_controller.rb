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
        render :template => '/home/show'
      end
    end
  end

  def approve
    contribution_to_approve = StoryContribution.find params[:story_contribution_id]
    contribution_to_approve.approver = current_user
    contribution_to_approve.save
    StoryContribution.awaiting_approval.each do |story_contribution|
      story_contribution.rejected = true
      story_contribution.save
    end
    redirect_to admin_index_url
  end
end
