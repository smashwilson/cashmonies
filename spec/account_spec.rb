require_relative 'spec_helper'

describe 'Account' do
  it 'serializes itself as a Hash' do
    a = Account.new
    a.name = 'Personal'
    a.lastfour = 1234
    a.kind = :debt

    a.to_h.should == {
      'name' => 'Personal',
      'lastfour' => 1234,
      'kind' => :debt
    }
  end

  it 'deserializes itself from a Hash' do
    a = Account.from_h({
      'name' => 'Derp',
      'lastfour' => 4321,
      'kind' => 'savings'
    })

    a.name.should == 'Derp'
    a.lastfour.should == 4321
    a.kind.should == :savings
  end


  describe 'transactions' do
    let(:account) do
      Account.from_h name: 'Hurf', lastfour: 4321, kind: :checking
    end

    let(:transactions) do
      [
        { uuid: '1', timestamp: '2014-01-01', code: :food, description: 'a', amount: 100 },
        { uuid: '2', timestamp: '2014-01-02', code: :food, description: 'b', amount: 200 },
        { uuid: '3', timestamp: '2014-06-24', code: :house, description: 'c', amount: 300 },
        { uuid: '4', timestamp: '2014-02-05', code: :coop, description: 'd', amount: 400 },
        { uuid: '5', timestamp: '2014-03-11', code: :gas, description: 'e', amount: 500 },
      ].map { |h| Transaction.from_h(h) }
    end

    before do
      transactions.each { |t| account.transactions << t }
    end

    it 'enumerates in time order' do
      ordered = account.ordered_transactions.map(&:description)
      ordered.should == %w{a b d e c}
    end

    it 'enumerates month by month' do
      seen = []
      account.transactions_by_month do |month, txs|
        seen << month
        ds = txs.map &:description

        case month
        when '2014-01'
          expect(ds).to eq(%w{a b})
        when '2014-02'
          expect(ds).to eq(%w{d})
        when '2014-03'
          expect(ds).to eq(%w{e})
        when '2014-06'
          expect(ds).to eq(%w{c})
        else
          fail "Unexpected month: #{month}"
        end
      end

      expect(seen).to eq(%w{2014-01 2014-02 2014-03 2014-06})
    end
  end
end
