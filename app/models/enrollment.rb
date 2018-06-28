# frozen_string_literal: true

class Enrollment < ApplicationRecord
  has_many :registrations
  belongs_to :team
  belongs_to :tournament
end
