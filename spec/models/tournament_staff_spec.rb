require 'rails_helper'

RSpec.describe TournamentStaff, type: :model do
   it { should belong_to(:user) }
   it { should belong_to(:tournament) }
end
