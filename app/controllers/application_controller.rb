class ApplicationController < ActionController::Base
        # Cookie や CORS の設定ができるようになる
        include DeviseTokenAuth::Concerns::SetUserByToken
end
