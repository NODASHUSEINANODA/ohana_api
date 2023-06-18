# frozen_string_literal: true

class EmployeesController < ApplicationController
  before_action :authenticate_company!

  def index
    @employees = Employee.where(company_id: current_company.id)
    search_condition
  end

  def create
    @employee = Employee.new(employee_params)
    @employee.company_id = current_company.id

    if @employee.invalid? || admin_invalid?
      flash[:danger] = @employee.errors.full_messages.join('、')
    elsif is_manager? ? @employee.save_with_manager(params[:employee][:admin_mail_address], params[:employee][:is_president]) : @employee.save
      flash[:success] = '社員を登録しました'
    else
      flash[:danger] = '社員の登録に失敗しました'
    end

    redirect_to employees_path
  end

  def update
    @employee = Employee.find(params[:id])

    if @employee.update(employee_params)
      flash[:success] = '社員情報を更新しました'
    else
      flash[:danger] = '社員情報の更新に失敗しました'
    end
    redirect_to employees_path
  end

  def destroy
    @employee = Employee.find(params[:id])
    @name = @employee.name

    if @employee.destroy
      flash[:success] = "#{@name}さんを削除しました"
    else
      flash[:danger] = "#{@name}さんの削除に失敗しました"
    end
    redirect_to employees_path
  end

  private

  # 管理者権限がある かつ 管理者用アドレスが空 の場合、invalid とする
  def admin_invalid?
    return false unless is_manager?
    return false if params[:employee][:admin_mail_address].present?

    @employee.errors.add(:base, '管理者のメールアドレスを入力してください')
    true
  end

  def is_manager?
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

  # TODO: ログインユーザーの会社IDを取得する(@userにはログインユーザーの情報を入れて、どのcontrollerでも使えるようにする)
  def company_condition
    return nil unless @user

    { company_id: @user.id }
  end

  def employee_params
    params.require(:employee).permit(:name, :sex, :birthday, :address, :joined_at, :phone_number, :message, :company_id)
  end
end
