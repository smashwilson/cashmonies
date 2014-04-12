require_relative 'spec_helper'

describe 'Transaction' do
  it 'converts itself to a Hash' do
    t = Transaction.new
    t.timestamp = Time.parse('2014-01-02')
    t.code = :food
    t.description = 'Indian buffet'
    t.amount = 1000

    t.to_h.should == {
      uuid: t.uuid,
      timestamp: '2014-01-02',
      code: 'food',
      description: 'Indian buffet',
      amount: 1000
    }
  end

  it 'reconstructs itself from a Hash'
  it 'assigns each Transaction a unique identifier'
end
