class StoryContributionsController < InheritedResources::Base
  before_filter :authenticate, :only => :approve

  def create
    create!(:notice => "Thank you! Your contribution is awaiting moderation") { root_url }
  end

  def approve
    require "pp"
    StoryContribution.update params[:story_contribution_id], :approver => current_user
    StoryContribution.awaiting_approval.each do |story_contribution|
      story_contribution.rejected = true
      story_contribution.save
    end
    redirect_to admin_index_url
  end
end
