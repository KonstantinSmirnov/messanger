class MessagesController < ApplicationController
  before_action :require_login

  def new
    @message = Message.new
  end

  def create
    current_user = User.find(params[:user_id])
    @message = current_user.sent_messages.build(message_params)
    
    if @message.valid?
      recipient_emails = params[:message][:recipient_email].split(',')
      recipient_emails.each do |email|
        recipient = User.find_by(email: email.strip)
        message = current_user.sent_messages.build(message_params)
        message.recipient = recipient
        message.save
      end

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
