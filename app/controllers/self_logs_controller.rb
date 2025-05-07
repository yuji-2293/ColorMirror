class SelfLogsController < ApplicationController
  before_action :authenticate_user!, only: [ :ai_response ]

  def ai_response
        @self_log = SelfLog.includes(:response).find(params[:id])
        respond_to do |format|
          format.turbo_stream
        end
  end
end
