# frozen_string_literal: true

class AddNullConstraintToTeamName < ActiveRecord::Migration[5.2]
  def change
    change_column_null :teams, :name, false
  end
end
