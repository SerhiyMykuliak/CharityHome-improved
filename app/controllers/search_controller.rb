class SearchController < ApplicationController
  def index
    if params[:query].present?
      @results = Searchkick.search(params[:query], models: [Cause, Volunteer])
    else
      @results = []
    end
  end
end
