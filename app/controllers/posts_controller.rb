#!/bin/env ruby  
# encoding: utf-8
require 'open-uri'

class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    # returnStr = params[:echostr]

    # render text: returnStr 

    respond_to do |format|
      format.html # index.html.erb
      # format.text text: "Hello"
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    main_url = "http://eee.hbut.edu.cn/"

    for i in 1..14
      my_url = "http://eee.hbut.edu.cn/html/ZXZX/XWZX/list_16_"+ i.to_s + ".html"
      html = open(my_url).read
      doc = Nokogiri::HTML(html)

      doc.css('table')[1].css('tr')[2].css('table')[3].css('tr')[3].css('table')[0].css('a').each do |link|
        p = Post.new

        post_url = main_url + link['href']
        html = open(post_url).read
        doc = Nokogiri::HTML(html)
        break if doc.to_s.length < 1000
        post = doc.css('table')[1].css('tr')[2].css('table')[3].css('tr')[3].css('table')[0]
        p.postUrl = post_url
        p.title = post.css('td')[1].content
        p.time  = post.css('td')[2].content.to_s.sub(/发布时间：/,"").sub(/    浏览次数：     〖返回列表〗/,"")
        p.content = post.css('tr')[4].content
        p.images = ""
        post.css('img').each do |img|
          img['src'] = main_url + img['src'] unless img['src'].include?"http://"
          p.images = p.images + "," + img['src']
        end
        p.save
      end
    end

    # respond_to do |format|
    #   format.html # new.html.erb
    #   format.json { render json: @post }
    # end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
