class Message < ActiveRecord::Base
  attr_accessible :Content, :CreateTime, :FromUserName, :FuncFlag, :MsgType, :ToUserName
end
