# frozen_string_literal: true

require 'rspec'
require_relative '../periods_chain'

RSpec.describe PeriodsChain do
  describe 'valid periods' do
    it 'should return true' do
      expect(PeriodsChain.new('16.07.2023', %w[2023 2024 2025]).valid?).to eq(true)
      expect(PeriodsChain.new('31.01.2023', %w[2023M1 2023M2 2023M3]).valid?).to eq(true)
      expect(PeriodsChain.new('04.06.1976', %w[1976M6D4 1976M6D5 1976M6D6]).valid?).to eq(true)
      expect(PeriodsChain.new('30.01.2023', %w[2023M1 2023M2 2023M3D30]).valid?).to eq(true)
      expect(PeriodsChain.new('30.01.2020',
                              %w[2020M1 2020 2021 2022 2023 2024M2 2024M3D30]).valid?).to eq(true)
    end

    it 'should return false' do
      expect(PeriodsChain.new('24.04.2023', %w[2023 2025 2026]).valid?).to eq(false)
      expect(PeriodsChain.new('10.01.2023', %w[2023M1 2023M3 2023M4]).valid?).to eq(false)
      expect(PeriodsChain.new('02.05.2023', %w[2023M5D2 2023M5D3 2023M5D5]).valid?).to eq(false)
      expect(PeriodsChain.new('31.01.2023', %w[2023M1 2023M2 2023M3D30]).valid?).to eq(false)
      expect(PeriodsChain.new('30.01.2020',
                              %w[2020M1 2020 2021 2022 2023 2024M2 2024M3D29]).valid?).to eq(false)
    end
  end
end
