class ManagersController < ApplicationController
  def index
    @birthday_in_next_month_members = current_company.birthday_in_next_month_members
  end
end
