#!/bin/env ruby  
# encoding: utf-8  
require 'open-uri'

class Post < ActiveRecord::Base
  attr_accessible :content, :time, :title, :images

  def fetch
    main_url = "http://eee.hbut.edu.cn/"

    for i in 1..14
      my_url = "http://eee.hbut.edu.cn/html/ZXZX/XWZX/list_16_"+ i.to_s + ".html"
      html = open(my_url).read
      doc = Nokogiri::HTML(html)

      doc.css('table')[1].css('tr')[2].css('table')[3].css('tr')[3].css('table')[0].css('a').each do |link|
        @p = Post.new

        post_url = main_url + link['href']
        html = open(post_url).read
        doc = Nokogiri::HTML(html)
        post = doc.css('table')[1].css('tr')[2].css('table')[3].css('tr')[3].css('table')[0]
        @p.title   = post.css('td')[1].content
        @p.time    = post.css('td')[2].content
        @p.content = post.css('tr')[4].content
        # puts "Time   :" + post.css('td')[2].content
        # puts "Content:" + post.css('tr')[4].content
        # puts "Images :"
        post.css('img').each do |img|
          @p.images = @p.images + img['src']
        end
        @p.save
      end
    end
  end

end
