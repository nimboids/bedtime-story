class StoryContribution < ActiveRecord::Base
  belongs_to :approver, :class_name => "User"
  named_scope :approved, :conditions => "approver_id is not null"
  named_scope :awaiting_approval, :conditions => "approver_id is null and rejected != true"
  validates_presence_of :text
  validates_length_of :text, :maximum => 140
  validates_length_of :name, :maximum => 100, :allow_blank => true
  attr_accessible :text, :name

  def before_create
    self.original_text = text
  end

  def self.approve id_to_approve, approver, edited_text
    contribution_to_approve = find id_to_approve
    contribution_to_approve.text = edited_text
    contribution_to_approve.approver = approver
    contribution_to_approve.save!
    awaiting_approval.update_all :rejected => true
  end
end
