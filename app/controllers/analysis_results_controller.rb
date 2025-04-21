class AnalysisResultsController < ApplicationController
  def index
    @end_date = Date.current
    @start_date = @end_date - 6.days
  end
end
