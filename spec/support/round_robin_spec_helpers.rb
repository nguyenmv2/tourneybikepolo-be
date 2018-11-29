# frozen_string_literal: true

module RoundRobinSpecHelpers
  def games_scheduled(round_robin, team_id)
    iterator(round_robin, team_id)
  end

  def byes_scheduled(round_robin)
    iterator(round_robin, nil)
  end

  def iterator(round_robin, selector)
    round_robin.map do |round|
      round.map do |game|
        game & [selector]
      end
    end
  end
end
