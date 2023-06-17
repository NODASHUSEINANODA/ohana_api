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

    validates :mail, :status, presence: true
end
