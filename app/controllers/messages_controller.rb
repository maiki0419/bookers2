class MessagesController < ApplicationController
  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(message_params.merge(user_id: current_user.id))
      redirect_back(fallback_location: root_path)
    else
      flash[:notice] = "メッセージ送信に失敗しました。"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :room_id, :user_id)
  end

end
