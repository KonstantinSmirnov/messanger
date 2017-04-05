class DraftsController < ApplicationController
  def index
    @drafts = current_user.drafts
  end

  def destroy
    @draft = Draft.find(params[:id])
    @draft.delete
    flash[:success] = 'Draft has been deleted'
    redirect_to user_drafts_path(current_user)
  end
end
