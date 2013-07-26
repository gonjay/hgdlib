class MessagesController < ApplicationController
  http_basic_authenticate_with name: "gonjay", password: "gon_jay"

  def index
    @messages = Message.all
  end
end
