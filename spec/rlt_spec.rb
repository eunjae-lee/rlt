# frozen_string_literal: true

RSpec.describe Rlt do
  it 'has a version number' do
    expect(Rlt::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end

  it 'tests thor' do
    Rlt::CLI.start(['hello', 'hehe'])
  end
end
