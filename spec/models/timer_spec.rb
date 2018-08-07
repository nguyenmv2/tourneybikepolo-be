# frozen_string_literal: true

require "rails_helper"

RSpec.describe Timer, type: :model do
  it { should belong_to(:match).dependent(:destroy) }

  it do
    should define_enum_for(:status).with(
      "in_progress"=>"in_progress",
      "paused"=>"paused",
      "expired"=>"expired",
      "canceled"=>"canceled"
    )
  end
end
