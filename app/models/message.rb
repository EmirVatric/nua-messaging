class Message < ApplicationRecord
  after_create :increment_user_inbox
  after_update :decrement_user_inbox
  belongs_to :inbox
  belongs_to :outbox

  def increment_user_inbox
    self.inbox.update(new_messages: self.inbox.new_messages+1)
  end

  def decrement_user_inbox
    self.inbox.update(new_messages: self.inbox.new_messages-1) if self.read_changed?
  end
end