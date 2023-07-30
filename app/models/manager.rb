# frozen_string_literal: true

class Manager < ApplicationRecord
  belongs_to :employee

  validates :email, presence: true
  validates :is_president, inclusion: [true, false]
  validate :only_one_president

  scope :presidents, -> { where(is_president: true) }

  def only_one_president
    return unless employee.company.president && is_president

    errors.add(:base, '社長は1人しか登録できません')
  end

  def remind_to_president
    ManagerMailer.with(
      president_name: employee.name,
      president_email: email
    ).remind_to_president.deliver_now
  end
end
