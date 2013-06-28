class BooksController < ApplicationController
  def index

  end

  def openlink
    @content = Book.new.search_index(params)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @content }
    end
  end
end
