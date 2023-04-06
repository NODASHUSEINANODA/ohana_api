class ApplicationController < ActionController::API
        # Cookie や CORS の設定ができるようになる
        include DeviseTokenAuth::Concerns::SetUserByToken
end
