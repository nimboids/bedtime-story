class HomeController < ApplicationController
  def show
    @story_contributions = StoryContribution.approved
    @finish_date = FINISH_DATE
  end
end
