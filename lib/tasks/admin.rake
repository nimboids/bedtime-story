namespace :admin do
  desc "Clear all story submissions"
  task :clear => :environment do
    StoryContribution.destroy_all
  end
end
