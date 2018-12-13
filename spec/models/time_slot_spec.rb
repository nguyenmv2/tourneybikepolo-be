# frozen_string_literal: true

require "rails_helper"

RSpec.describe TimeSlot, type: :model do
  it { should belong_to(:tournament) }
end
