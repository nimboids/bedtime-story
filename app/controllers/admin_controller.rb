class AdminController < ApplicationController
  before_filter :authenticate

  def index
    @story_contributions = StoryContribution.awaiting_approval
  end
end
