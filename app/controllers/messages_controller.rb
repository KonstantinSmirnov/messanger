class MessagesController < ApplicationController
  before_action :require_login

  def new
    @message = Message.new
  end

  def create
    current_user = User.find(params[:user_id])
    @message = current_user.sent_messages.build(message_params)
    recipient = User.find_by(email: params[:message][:recipient_email])
    flash.now[:danger] = 'Recipient not found. Check if email is valid.' if recipient == nil
    @message.recipient = recipient

    if @message.save
      flash[:success] = 'Message was successfully sent'
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:recipient, :recipient_email, :topic, :text)
  end
end
