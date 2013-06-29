#!/bin/env ruby  
# encoding: utf-8  
require 'open-uri'

class Book < ActiveRecord::Base
  attr_accessible :name
  attr_accessor :index_number, :status, :img_src, :id_code, :auther, :publisher

  def search_index(params)
    @url = 'http://202.114.181.3:8080/opac/openlink.php?' +
     'strText=' + params[:strText].to_s + 
     '&strSearchType=' + params[:strSearchType].to_s + 
     '&match_flag=' + params[:match_flag].to_s + 
     '&historyCount=' + params[:historyCount].to_s +
     '&doctype=' + params[:doctype].to_s + 
     '&displaypg=' + params[:displaypg].to_s+ 
     '&showmode=' + params[:showmode].to_s+ 
     '&sort=' + params[:sort].to_s+ 
     '&orderby=' + params[:orderby].to_s+ 
     '&location=' + params[:location].to_s

     html = open(URI.escape(@url)).read
     doc = Nokogiri::HTML(html)
     @books = []

     doc.css('.book_article')[3].css('.book_list_info').each do |item|
      @book = Book.new
      @book.img_src = item.css('img')[0]['src']
      @book.id_code = item.css('h3')[0].css('a')[0]['href']
      @book.name = item.css('h3')[0].css('a')[0].content
      @book.index_number = item.css('h3')[0].css('span')[0].content + item.css('h3')[0].content.split("#{@book.name}")[1]
      @book.status = item.css('p')[0].css('span')[0].content
      p_content = item.css('p')[0].content.split("#{@book.status}")[1]
      if p_content.include?(".")
        p = p_content.split(".")
        @book.auther = p[0]
        @book.publisher = p[1]
      else
        p = p_content.split("著")
        @book.auther = p[0]
        @book.publisher = p[1]
      end
      @books << @book
     end

     @books
    
  end

end