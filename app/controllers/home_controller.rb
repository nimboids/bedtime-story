class HomeController < ApplicationController
  def show
    @story_contribution = StoryContribution.new
  end
end
