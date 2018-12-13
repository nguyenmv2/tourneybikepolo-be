# frozen_string_literal: true

class PlayingSpace < ApplicationRecord
  belongs_to :tournament

  validates_uniqueness_of :name, scope: :tournament_id, case_sensitive: false
end
