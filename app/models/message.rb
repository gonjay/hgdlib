#!/bin/env ruby  
# encoding: utf-8
class Message < ActiveRecord::Base
  attr_accessible :Content, :CreateTime, :FromUserName, :FuncFlag, :MsgType, :ToUserName, :Status

  def subStr1
    "<xml>
    <ToUserName>#{self.FromUserName}</ToUserName>
    <FromUserName>#{self.ToUserName}</FromUserName>
    <CreateTime>#{self.CreateTime}</CreateTime>
    <MsgType>#{self.MsgType}</MsgType>
    <Content>"
  end

  def subStr2
    "</Content>
    <FuncFlag>0</FuncFlag>
    </xml>"
  end

  def frontPeopleNum
    Message.where("Status = ? AND created_at < ?", true, self.created_at).count
  end

  def rearPeopleNum
    Message.where("Status = ? AND created_at > ?", true, self.created_at).count
  end

  def averageWaitTime
    # 查询近2个小时以内的，并且排在队列第一个的平均等待时间
    # 
    messages = Message.where("Status = ? AND created_at > ?", false, 2.hour.ago)
    if messages != []
      t = 0
      messages.each do |me|
        t = me.updated_at - me.created_at
      end
      return t / messages.count
    end
    return 0
  end

  def waitTime
    return "您可以准备进入餐馆了" if frontPeopleNum < 1
    "大约还需要等待#{(averageWaitTime.to_i/60) * frontPeopleNum}分钟"
  end

  def returnQueueStatus
    subStr1 + "微信排队\n\n
    欢迎来到：江滨路首府甲第大酒店\n
    现在时间是：#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")}\n\n
    您的号码是：#{self.id}\n
    在你前面有#{frontPeopleNum}位客人。\n" + waitTime + subStr2
  end
end
