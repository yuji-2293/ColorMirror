class AnalysisResultsController < ApplicationController
  def index
    @start_date = Date.today.beginning_of_week
    @end_date = Date.today.end_of_week
  end
end
