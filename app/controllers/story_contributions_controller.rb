class StoryContributionsController < InheritedResources::Base
  def create
    create!(:notice => "Thank you! Your contribution is awaiting moderation") { root_url }
  end
end
