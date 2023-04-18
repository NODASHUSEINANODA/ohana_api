class Api::EmployeesController < ApplicationController
  def index
    # TODO: ログインユーザーの情報から会社に絞って社員を取得する(関係ない会社の社員まで取得するとSQL的に無駄な処理が多い)
    @employees = Employee.all
    search_condition

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
    @employees = @employees
      .where(name_condition)
      .where(sex_condition)
      .where(birthday_condition)
      .where(address_condition)
      .where(work_year_condition)
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

  def work_year_condition
    return nil if params[:work_year].blank?

    { work_year: params[:work_year] }
  end

  def phone_number_condition
    return nil if params[:phone_number].blank?

    Employee.arel_table[:phone_number].matches("%#{params[:phone_number]}%")
  end

  def message_condition
    return nil if params[:message].blank?

    Employee.arel_table[:message].matches("%#{params[:message]}%")
  end

  # TODO: ログインユーザーの会社IDを取得する(@userにはログインユーザーの情報を入れて、どのcontrollerでも使えるようにする)
  def company_condition
    return nil unless @user

    { company_id: @user.id }
  end

  def employee_params
    params.require(:employee).permit(:name, :sex, :birthday, :address, :work_year, :phone_number, :message)
  end

end