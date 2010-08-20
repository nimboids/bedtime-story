class CreateStoryContributions < ActiveRecord::Migration
  def self.up
    create_table :story_contributions do |t|
      t.timestamps
      t.string :text
    end
  end

  def self.down
    drop_table :story_contributions
  end
end
