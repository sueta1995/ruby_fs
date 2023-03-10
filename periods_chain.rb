require 'date'

class PeriodsChain
	def initialize(chain, start_date)
		@start_date = Date.parse(start_date)
		@chain = chain
	end

	def valid?
		puts convert_time
	end

	def add(new_period_type)

	end

	private

	def convert_time
		@chain.collect { |c| c = c.gsub(/[DM]/, ' ').split.map(&:to_i) }
	end
end