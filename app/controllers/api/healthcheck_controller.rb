class Api::HealthcheckController < ApplicationController
  def index
    render json: { message: 'healthcheck success!!'}, status: 200
  end
end
