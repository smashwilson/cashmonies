require_relative 'spec_helper'

describe 'Storage' do
  let(:storage) { Storage.new }

  it 'loads Transactions from a YAML file' do
    ts = storage.load_transactions(fixture_path 'transactions.yml')
    expect(ts.length).to eq(3)

    expect(ts[0].uuid).to eq('1')
    expect(ts[0].timestamp).to eq(Time.new(2014, 1, 1))
    expect(ts[0].code).to be(:food)
    expect(ts[0].description).to eq('groceries')
    expect(ts[0].amount).to eq(9000)

    expect(ts[1].uuid).to eq('2')
    expect(ts[1].timestamp).to eq(Time.new(2014, 1, 2))
    expect(ts[1].code).to be(:food)
    expect(ts[1].description).to eq('groceries')
    expect(ts[1].amount).to eq(1000)

    expect(ts[2].uuid).to eq('3')
    expect(ts[2].timestamp).to eq(Time.new(2014, 1, 3))
    expect(ts[2].code).to be(:house)
    expect(ts[2].description).to eq('stuff')
    expect(ts[2].amount).to eq(4500)
  end

  it 'loads Account metadata from a YAML file' do
    a = storage.load_account(fixture_path 'account.yml')
    expect(a.name).to eq('Primary Checking')
    expect(a.lastfour).to eq(9999)
    expect(a.kind).to eq(:checking)
  end

  it 'reads an Account from a directory'
  it 'writes Transactions to a YAML file'
  it 'writes Accounts to a directory'
end
