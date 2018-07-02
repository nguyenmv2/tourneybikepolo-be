# frozen_string_literal: true

require "rails_helper"

describe Roster, type: :model do
   it { should belong_to(:player) }
   it { should belong_to(:team) }
end
