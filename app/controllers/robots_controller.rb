#!/bin/env ruby  
# encoding: utf-8
class RobotsController < ApplicationController
  def index
    returnStr = params[:echostr]
    render text: returnStr 
  end

  def create
    query_type = params[:xml][:MsgType]
    returnTestNewStr = " <xml>
                    <ToUserName>#{params[:xml][:FromUserName]}</ToUserName>
                    <FromUserName>#{params[:xml][:ToUserName]}</FromUserName>
                    <CreateTime></CreateTime>
                    <MsgType>text</MsgType>
                    <Content>Message.new success</Content>
                    <FuncFlag>0</FuncFlag>
                    </xml>"
    returnTestSaveStr = " <xml>
                    <ToUserName>#{params[:xml][:FromUserName]}</ToUserName>
                    <FromUserName>#{params[:xml][:ToUserName]}</FromUserName>
                    <CreateTime></CreateTime>
                    <MsgType>text</MsgType>
                    <Content>Message.save success</Content>
                    <FuncFlag>0</FuncFlag>
                    </xml>"
    if query_type == "text"
      # returnStr = params[:xml][:Content]
      render text: returnTestNewStr if @me = Message.new(params[:xml])
      render text: returnTestSaveStr if @me.save
      returnStr = " <xml>
                    <ToUserName>#{params[:xml][:FromUserName]}</ToUserName>
                    <FromUserName>#{params[:xml][:ToUserName]}</FromUserName>
                    <CreateTime></CreateTime>
                    <MsgType>text</MsgType>
                    <Content>Welcome to weixin #{params[:xml][:Content]}</Content>
                    <FuncFlag>0</FuncFlag>
                    </xml>"
    else 
      returnStr = " <xml>
                    <ToUserName>#{params[:xml][:FromUserName]}</ToUserName>
                    <FromUserName>#{params[:xml][:ToUserName]}</FromUserName>
                    <CreateTime></CreateTime>
                    <MsgType>text</MsgType>
                    <Content>Welcome to weixin</Content>
                    <FuncFlag>0</FuncFlag>
                    </xml>"
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