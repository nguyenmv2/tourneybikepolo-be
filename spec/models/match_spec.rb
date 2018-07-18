# frozen_string_literal: true

require "rails_helper"

describe Match, type: :model do
  it { should belong_to(:tournament) }
  it { should belong_to(:team_one).class_name("Team").with_foreign_key("team_one_id") }
  it { should belong_to(:team_two).class_name("Team").with_foreign_key("team_two_id") }
end
