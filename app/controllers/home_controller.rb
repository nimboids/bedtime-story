class HomeController < ApplicationController
  def show
    response.headers["Cache-Control"] = "public, max-age=1"
    @story_contribution = StoryContribution.new
  end
end
