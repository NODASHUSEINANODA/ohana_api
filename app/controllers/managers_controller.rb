class ManagersController < ApplicationController
  def index
    @employees_with_birthdays_next_month = current_company.employees_with_birthdays_next_month
  end
end
