# frozen_string_literal: true

class OrderDetail < ApplicationRecord
  include Discard::Model

  belongs_to :order
  belongs_to :employee
  belongs_to :menu

  enum deliver_to: { company: 0, home: 1}
end
