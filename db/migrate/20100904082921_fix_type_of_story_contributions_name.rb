class FixTypeOfStoryContributionsName < ActiveRecord::Migration
  def self.up
    change_column :story_contributions, :name, :string
  end

  def self.down
    change_column :story_contributions, :name, :text
  end
end
