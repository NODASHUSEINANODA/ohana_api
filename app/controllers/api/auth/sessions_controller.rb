class Api::Auth::SessionsController < ApplicationController
    def index
        render json: {is_login: false, message: "ユーザーが存在しません"}, status: 401 unless current_api_company

        render json: {is_login: true, data: current_api_company }
    end
end
