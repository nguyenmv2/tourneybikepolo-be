require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  it { should have_many(:registrations) }
  it { should belong_to(:team) }
  it { should belong_to(:tournament) }
end
