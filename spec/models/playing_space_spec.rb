# frozen_string_literal: true

require "rails_helper"

RSpec.describe PlayingSpace, type: :model do
  it { should belong_to(:tournament) }
end
