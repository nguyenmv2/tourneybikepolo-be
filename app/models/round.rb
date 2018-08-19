# frozen_string_literal: true

class Round < ApplicationRecord
  TYPES = %w(round_robin swiss_rounds single_elimination double_elimination).freeze
  enum format_type: Hash[TYPES.zip(TYPES)].symbolize_keys

  belongs_to :tournament

  validates :format_type, presence: true
end
