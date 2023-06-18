# frozen_string_literal: true

class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :employee
  belongs_to :menu

  enum :deliver_to, %i[company home]
end
