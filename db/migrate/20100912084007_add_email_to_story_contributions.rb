class AddEmailToStoryContributions < ActiveRecord::Migration
  def self.up
    add_column :story_contributions, :email, :string
  end

  def self.down
    remove_column :story_contributions, :email
  end
end
