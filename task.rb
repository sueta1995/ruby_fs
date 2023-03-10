# frozen_string_literal: true

require './periods_chain'

new_period_type = gets.chomp
periods_chain = PeriodsChain.new('30.01.2023',
                                 %w[2023M1D30 2023M1 2023M2 2023 2024M3 2024M4D30 2025M5])

puts periods_chain.valid?

periods_chain.add(new_period_type)
