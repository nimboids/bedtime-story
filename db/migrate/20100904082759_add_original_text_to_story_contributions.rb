class AddOriginalTextToStoryContributions < ActiveRecord::Migration
  def self.up
    add_column :story_contributions, :original_text, :string
  end

  def self.down
    remove_column :story_contributions, :original_text
  end
end
