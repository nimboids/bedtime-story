class AddRejectedToStorySubmissions < ActiveRecord::Migration
  def self.up
    add_column :story_contributions, :rejected, :boolean, :default => false
  end

  def self.down
    remove_column :story_contributions, :rejected
  end
end
