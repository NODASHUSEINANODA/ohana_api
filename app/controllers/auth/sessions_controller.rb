class Auth::SessionsController < ApplicationController
    def index
        render json: {is_login: true, data: current_user } if current_user
        render json: {is_login: false, message: "ユーザーが存在しません"}, status: 401
    end
end
