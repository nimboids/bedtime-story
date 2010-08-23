class HomeController < ApplicationController
  def show
    @story_contributions = StoryContribution.all
  end
end
