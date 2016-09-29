class SearchController < ApplicationController
  def index
    if params[:search].nil?
      @users = User.all
    else
      @users = User.search(params[:search])
    end
  end
end
