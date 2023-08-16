# frozen_string_literal: true

class EmployeesController < ApplicationController
  before_action :authenticate_company!
  before_action :set_employees, only: [:index]
  before_action :set_new_employee, only: [:create]
  before_action :set_employee, only: %i[update destroy]

  def index
    @employees = Employee.where(company_id: current_company.id)
    search_condition
  end

  def create
    return redirect_to employees_path if add_flash_danger_if_invalid

    # 管理者権限がある場合(管理者 or 社長)
    if manager?
      return redirect_to employees_path if add_flash_danger_if_admin_invalid

      begin
        @employee.save_with_manager(params[:employee][:admin_mail_address], params[:employee][:is_president])
        flash[:success] = '管理者の権限を持った社員を登録しました'
      rescue ActiveRecord::RecordInvalid => e
        flash[:danger] = e.record.errors.full_messages.join(', ')
      end
    elsif @employee.birthday_is_next_month?
      @employee.save_with_order_detail(current_company)
      flash[:success] = '社員を登録しました'
    elsif @employee.save!
      flash[:success] = '社員を登録しました'
    else
      flash[:danger] = '社員の登録に失敗しました'
    end

    redirect_to employees_path
  end

  def update
    if @employee.update(employee_params)
      flash[:success] = '社員情報を更新しました'
    else
      flash[:danger] = '社員情報の更新に失敗しました'
    end
    redirect_to employees_path
  end

  def destroy
    name = @employee.name

    if @employee.manager ? @employee.destroy_with_manager : @employee.discard
      flash[:success] = "#{name}さんを削除しました"
    else
      flash[:danger] = "#{name}さんの削除に失敗しました"
    end
    redirect_to employees_path
  end

  private

  def set_employees
    @employees = Employee.where(company_id: current_company.id)
  end

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def set_new_employee
    @employee = Employee.new(employee_params)
    @employee.company_id = current_company.id
    @employee.address = employee_params[:address].present? ? employee_params[:address] : nil
    @employee.phone_number = employee_params[:phone_number].present? ? employee_params[:phone_number] : nil
  end

  def add_flash_danger_if_invalid
    return unless @employee.invalid?

    flash[:danger] = @employee.errors.full_messages.join('、')
  end

  def add_flash_danger_if_admin_invalid
    return unless admin_invalid?

    # return unless @employee.invalid? || admin_invalid?

    flash[:danger] = @employee.errors.full_messages.join('、')
  end

  # 管理者権限がある かつ 管理者用アドレスが空 の場合、invalid とする
  def admin_invalid?
    return false unless manager?
    return false if params[:employee][:admin_mail_address].present?

    @employee.errors.add(:base, '管理者のメールアドレスを入力してください')
    true
  end

  def manager?
    return false if ActiveRecord::Type::Boolean.new.cast(params[:employee][:is_president]).nil?

    true
  end

  def search_condition
    @employees = @employees
                  .where(name_condition)
                  .where(sex_condition)
                  .where(birthday_condition)
                  .where(address_condition)
                  .where(joined_at_condition)
                  .where(phone_number_condition)
                  .where(message_condition)
                  .where(company_condition)
                  .order_manager_is_president_desc
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

    Employee.arel_table[:birthday].extract('month').eq(params[:birthday].to_i)
  end

  def address_condition
    return nil if params[:address].blank?

    Employee.arel_table[:address].matches("%#{params[:address]}%")
  end

  # TODO: 日付単体で検索するユースケースはないと思う。こちらもユースケースに応じた検索方法に変更した方が良いかも(現時点では日付で検索)
  def joined_at_condition
    return nil if params[:joined_at].blank?

    year = params[:joined_at][:year]
    month = params[:joined_at][:month]

    return Employee.arel_table[:joined_at].extract('month').eq(month.to_i) if year.nil?
    return Employee.arel_table[:joined_at].extract('year').eq(year.to_i) if month.nil?

    year_matches = Employee.arel_table[:joined_at].extract('year').eq(year.to_i)
    month_matches = Employee.arel_table[:joined_at].extract('month').eq(month.to_i)

    year_matches.and(month_matches)
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
    params.require(:employee).permit(:name, :sex, :birthday, :address, :joined_at, :phone_number, :message, :company_id)
  end
end
