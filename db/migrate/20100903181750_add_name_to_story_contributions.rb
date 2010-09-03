class AddNameToStoryContributions < ActiveRecord::Migration
  def self.up
    add_column :story_contributions, :name, :text
  end

  def self.down
    remove_column :story_contributions, :name
  end
end
