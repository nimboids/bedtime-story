class PagesController < ApplicationController
  def show
    #FIXME this doesn't belong here!
    @story_contributions = StoryContribution.all

    render :action => params[:page]
  end
end
