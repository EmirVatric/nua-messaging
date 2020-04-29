class PaymentsController < ApplicationController
  def lost_script
    begin
      PaymentProviderFactory.provider.debit_card(@current_user)
      Message.create(body: "New request for lost script for #{@current_user.full_name}",
                     outbox: @current_user.outbox, inbox: User.default_admin.inbox)
      Payment.create(user: @current_user)
      
      redirect_to messages_path, notice: "You have successfully requested a new script."
    rescue
      redirect_to messages_path, notice: "We are sorry, but we can't proccess you request right now."
    end
  end
end