class MessagesController < ApplicationController
  before_action :require_login

  def new
    @message = Message.new
  end

  def create
    if params[:create_draft]
      @draft = current_user.drafts.build(draft_params)
      if @draft.save
        flash[:success] = 'Draft has been saved'
        redirect_to root_path
      else
        flash[:danger] = "Can't save empty draft"
        redirect_to new_user_message_path(current_user)
      end
    else

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
  end

  def index
    @messages = current_user.received_messages.all
  end

  def show
    @message = Message.find(params[:id])
    @message.read!
  end

  def destroy
    @message = Message.find(params[:id])
    @message.delete
    flash[:success] = 'Message has been deleted'
    redirect_to user_messages_path(current_user)
  end

  private

  def message_params
    params.require(:message).permit(:recipient, :recipient_email, :topic, :text)
  end

  def draft_params
    params.require(:message).permit(:recipient_email, :topic, :text)
  end

end
