class HomeController < ApplicationController
  def show
    @story_contributions = StoryContribution.approved
  end
end
