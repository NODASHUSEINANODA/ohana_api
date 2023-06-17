# frozen_string_literal: true

class Manager < ApplicationRecord
  belongs_to :employee
  belongs_to :company
  has_many :histories
  has_many :temporaries

  validates :email, :status, presence: true
  validate :only_one_president

  # TODO: PRをmerge後、カラムをpresidentに変更する
  scope :presidents, -> { where(status: true) }

  def only_one_president
    return unless company.president

    errors.add(:base, '社長は1人しか登録できません')
  end

  def remind_to_president
    ManagerMailer.with(
      president_name: employee.name,
      president_email: email
    ).remind_to_president.deliver_now
  end
end
