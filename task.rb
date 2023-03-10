require './periods_chain'

new_period_type = gets.chomp
periods_chain = PeriodsChain.new(gets.chomp.split, new_period_type)

periods_chain.valid?

periods_chain.add(new_period_type)
