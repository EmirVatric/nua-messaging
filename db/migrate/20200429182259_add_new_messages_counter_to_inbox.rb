class AddNewMessagesCounterToInbox < ActiveRecord::Migration[5.0]
  def change
    add_column :inboxes, :new_messages, :integer, default: 0
  end
end
