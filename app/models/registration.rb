class Registration < ApplicationRecord
  belongs_to :team
  belongs_to :user
  belongs_to :enrollment
end
