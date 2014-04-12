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
    it 'enumerates in time order'
    it 'enumerates month by month'
  end
end
