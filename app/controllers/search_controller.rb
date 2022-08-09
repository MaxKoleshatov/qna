class SearchController < ApplicationController
    def index
      @result = Search.search_by(params[:query], params[:type])
    end
  end