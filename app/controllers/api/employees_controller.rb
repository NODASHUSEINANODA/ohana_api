class Api::EmployeesController < ApplicationController
  before_action :authenticate_api_company!

  def index
    @employees = search_condition

    render json: @employees
  end

  def show
    @employee = Employee.find(params[:id])
    render json: @employee
  rescue ActiveRecord::RecordNotFound
    render json: { error: '社員が見つかりませんでした' }, status: :not_found
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      render json: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  def update
    @employee = Employee.find(params[:id])
    @employee.update(employee_params)
    render json: @employee
  rescue ActiveRecord::RecordNotFound
    render json: { error: '社員が見つかりませんでした' }, status: :not_found
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    render json: @employee
  rescue ActiveRecord::RecordNotFound
    render json: { error: '社員が見つかりませんでした' }, status: :not_found
  end

  private

  def search_condition
    Employee
      .where(name_condition)
      .where(sex_condition)
      .where(birthday_condition)
      .where(address_condition)
      .where(joined_at_condition)
      .where(phone_number_condition)
      .where(message_condition)
      .where(company_condition)
      .distinct
  end

  def name_condition
    return nil if params[:name].blank?

    Employee.arel_table[:name].matches("%#{params[:name]}%")
  end

  def sex_condition
    return nil if params[:sex].blank?

    { sex: params[:sex] }
  end

  # TODO: 日付単体で検索するユースケースはないと思うので、範囲検索にした方が良いかも(front側では月のみをintで渡す)
  def birthday_condition
    return nil if params[:birthday].blank?

    { birthday: params[:birthday] }
  end

  def address_condition
    return nil if params[:address].blank?

    Employee.arel_table[:address].matches("%#{params[:address]}%")
  end

  # TODO: 日付単体で検索するユースケースはないと思う。こちらもユースケースに応じた検索方法に変更した方が良いかも(現時点では日付で検索)
  def joined_at_condition
    return nil if params[:joined_at].blank?

    { joined_at: params[:joined_at] }
  end

  def phone_number_condition
    return nil if params[:phone_number].blank?

    Employee.arel_table[:phone_number].matches("%#{params[:phone_number]}%")
  end

  def message_condition
    return nil if params[:message].blank?

    Employee.arel_table[:message].matches("%#{params[:message]}%")
  end

  def company_condition
    { company_id: current_api_company.id }
  end

  def employee_params
    params.require(:employee).permit(:name, :sex, :birthday, :address, :joined_at, :phone_number, :message, :company_id)
  end

end