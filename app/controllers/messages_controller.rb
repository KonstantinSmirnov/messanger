class MessagesController < ApplicationController
  before_action :require_login

  def new
    @message = Message.new
    if !params[:draft_id].nil?
      draft = Draft.find(params[:draft_id])
      @message.recipient_email = draft.recipient_email
      @message.topic = draft.topic
      @message.text = draft.text
    end
  end

  def create
    if params[:create_draft]
      @draft = current_user.drafts.build(draft_params)
      if @draft.save
        flash[:success] = 'Draft has been saved'
        redirect_to user_drafts_path(current_user)
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
    @contacts = []

    if params[:outbox] == 'true'
      current_user.sent_messages.collect(&:recipient_id).uniq.each { |u| @contacts << User.find(u) }
      @messages = current_user.sent_messages.filter(params).order('created_at desc').paginate(:page => params[:page])
    else
      current_user.received_messages.collect(&:sender_id).uniq.each { |u| @contacts << User.find(u) }
      @messages = current_user.received_messages.filter(params).order('created_at desc').paginate(:page => params[:page])
    end
  end

  def show
    @message = Message.find(params[:id])
    @message.read! if @message.recipient == current_user
  end

  def destroy
    @message = Message.find(params[:id])
    @message.delete
    flash[:success] = 'Message has been deleted'
    redirect_to user_messages_path(current_user, outbox: params[:outbox])
  end

  private

  def message_params
    params.require(:message).permit(:recipient, :recipient_email, :topic, :text)
  end

  def draft_params
    params.require(:message).permit(:recipient_email, :topic, :text)
  end

end
