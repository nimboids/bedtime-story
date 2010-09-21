class StoryContribution < ActiveRecord::Base
  belongs_to :approver, :class_name => "User"
  named_scope :approved, :conditions => "approver_id is not null", :order => 'id'
  named_scope :awaiting_approval, :conditions => "approver_id is null and rejected != true"
  validates_presence_of :text
  validates_length_of :text, :maximum => 140
  validates_length_of :name, :maximum => 100, :allow_blank => true
  validates_length_of :email, :maximum => 100, :allow_blank => true
  validates_acceptance_of :terms_and_conditions, :allow_nil => false, :on => :create
  attr_accessible :text, :name, :email, :terms_and_conditions

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
