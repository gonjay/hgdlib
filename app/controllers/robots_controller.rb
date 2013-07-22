class RobotsController < ApplicationController
  def index
    returnStr = params[:echostr]
    render text: returnStr 
  end

  def create
    query_type = params[:xml][:MsgType]
    if query_type == "text"
      returnStr = params[:xml][:Content]
    else 
      returnStr = "Ni fa de shi shen me?"
    end
    render text: returnStr

    # if query_type == "image"
    #     do_method_b
    # elsif query_type == "text"
    #     query = params[:xml][:Content]
    #     if query.start_with? "@"
    #         do_method_a
    #     else
    #         do_method_c
    #     end
    # end
  end

  # def do_method_b
  #   render text: "image" 
  # end

  # def do_me
    
  # end

end