# frozen_string_literal: true

class Temporary < ApplicationRecord
  belongs_to :employee
  belongs_to :manager
end
