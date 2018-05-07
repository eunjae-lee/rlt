# frozen_string_literal: true

RSpec.describe Rlt do
  it 'has a version number' do
    expect(Rlt::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end

  it 'tests thor' do
    expect do
      Rlt::CLI.start(['show'])
    end.to raise_error Rlt::GitNativeCommandError
  end
end
