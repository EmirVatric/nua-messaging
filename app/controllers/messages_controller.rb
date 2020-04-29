class MessagesController < ApplicationController
  def index
    @inbox = params[:filter] ? @current_user.unread_messages.order('created_at DESC').paginate(page: params[:page], per_page: 15) 
                            : @current_user.inbox.messages.order('created_at DESC').paginate(page: params[:page], per_page: 15)
    @outbox = @current_user.outbox.messages.order('created_at DESC').paginate(page: params[:page], per_page: 15)
  end

  def show
    @message = Message.find(params[:id])
    @message.update(read: true) if !@message.read && @current_user.inbox == @message.inbox
  end

  def new
    @message = Message.new
  end

  def create
    original_message = Message.find(params[:message][:message_id])
    @message = Message.new(message_params)
    @message.inbox = (original_message.created_at < Date.new-7.days && @current_user.is_patient) ?
                       User.default_admin.inbox : original_message.outbox.user.inbox
    @message.outbox = @current_user.outbox

    if @message.save
      redirect_to messages_path, notice: "Your message has been sent to #{@message.outbox.user.full_name}!"
    else
      render 'new'
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
