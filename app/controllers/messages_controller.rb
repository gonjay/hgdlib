class MessagesController < ApplicationController
  http_basic_authenticate_with name: "gonjay", password: "gon_jay"

  def index
    @messages = Message.where("Status = ?", true)
  end

  def new
    @me = Message.new()
  end

  def finish_queue
    @me = Message.find(params[:id])
    @me.Status = false
    @me.updated_at = Time.now
    @me.save
    redirect_to :back
  end
end
