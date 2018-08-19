# frozen_string_literal: true

require "rails_helper"

RSpec.describe Round, type: :model do
  it { should belong_to(:tournament) }
end
