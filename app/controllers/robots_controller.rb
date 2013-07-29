#!/bin/env ruby  
# encoding: utf-8
class RobotsController < ApplicationController
  def index
    returnStr = params[:echostr]
    render text: returnStr 
  end

  def create
    query_type = params[:xml][:MsgType]
    returnStr = " <xml>
    <ToUserName>#{params[:xml][:FromUserName]}</ToUserName>
    <FromUserName>#{params[:xml][:ToUserName]}</FromUserName>
    <CreateTime></CreateTime>
    <MsgType>text</MsgType>
    <Content>Welcome to weixin #{params[:xml][:Content]}</Content>
    <FuncFlag>0</FuncFlag>
    </xml>"
    if query_type == "text"

      @me = Message.where(FromUserName: params[:xml][:FromUserName])
      .first_or_create(
        Content: params[:xml][:Content],
        FromUserName: params[:xml][:FromUserName],
        ToUserName: params[:xml][:ToUserName],
        CreateTime: params[:xml][:CreateTime],
        MsgType: params[:xml][:MsgType],
        FuncFlag: params[:xml][:FuncFlag],
        Status: true) # 'true' means the person is queuing
      
    else 

    end
    
    if @me.save

      render text: @me.returnQueueStatus
    else
      render text: "fail?"
    end

  end


end