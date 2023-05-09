class HomeController < ApplicationController
  before_action :authenticate_company!

  def index
    @current_company = current_company
  end
end
