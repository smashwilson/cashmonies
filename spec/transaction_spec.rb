require_relative 'spec_helper'

describe 'Transaction' do
  it 'converts itself to a Hash' do
    t = Transaction.new
    t.timestamp = Time.parse('2014-01-02')
    t.code = :food
    t.description = 'Indian buffet'
    t.amount = 1000

    expect(t.to_h).to eq(
      'uuid' => t.uuid,
      'timestamp' => '2014-01-02',
      'code' => 'food',
      'description' => 'Indian buffet',
      'amount' => 1000
    )
  end

  it 'reconstructs itself from a Hash' do
    t = Transaction.from_h(
      'uuid' => '1234',
      'timestamp' => '2014-01-02',
      'code' => 'food',
      'description' => 'Indian buffet',
      'amount' => 1500
    )

    expect(t.uuid).to eq('1234')
    expect(t.timestamp).to eq(Time.parse('2014-01-02'))
    expect(t.code).to eq(:food)
    expect(t.description).to eq('Indian buffet')
    expect(t.amount).to eq(1500)
  end

  it 'assigns each Transaction a unique identifier' do
    t1 = Transaction.new
    t2 = Transaction.new
    expect(t1.uuid).not_to eq(t2.uuid)
  end
end
