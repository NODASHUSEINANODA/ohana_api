# SPA構成じゃなくなったので、不要だが、viewが見れる状態になったことを示すために残しておく
# TODO プルリクで確認してもらった後に削除する
class Api::HealthcheckController < ApplicationController
  def index
    @hoge = 'hoge'
  end
end
