require_relative 'spec_helper'

describe 'Dehasher' do
  let(:dehasher) do
    Dehasher.new({
      'numeric' => 1234,
      'text' => 'blerp',
      'symbolic' => 'Monday',
      'day' => '2014-01-02'
    })
  end

  it 'allows access by String' do
    dehasher.string('text').should == 'blerp'
  end

  it 'allows access by Symbol' do
    dehasher.string(:text).should == 'blerp'
  end

  describe 'type constraints' do
    it 'constrains to an Integer' do
      dehasher.integer(:numeric).should == 1234
      expect { dehasher.integer(:text) }.to raise_error(WrongTypeError)
    end

    it 'constrains to a date' do
      dehasher.time(:day).should == Time.new(2014, 1, 2)
      expect { dehasher.time(:text) }.to raise_error(WrongTypeError)
    end

    it 'constrains to a symbol'
    it 'constrains to an enum'
  end

  it 'detects missing attributes'
  it 'detects extra attributes'
end
