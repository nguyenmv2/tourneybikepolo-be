# frozen_string_literal: true

class MonetizeTournament < ActiveRecord::Migration[5.2]
  def change
    add_monetize :tournaments, :price
  end
end
