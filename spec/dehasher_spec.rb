require_relative 'spec_helper'

describe 'Dehasher' do
  let(:hash) do
    {
      'numeric' => 1234,
      'text' => 'blerp',
      'symbolic' => 'Monday',
      'day' => '2014-01-02'
    }
  end

  let(:dehasher) { Dehasher.new(hash) }

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

    it 'constrains to a symbol' do
      dehasher.symbol(:symbolic).should == :Monday
    end

    it 'constrains to an enum' do
      dehasher.enum(:symbolic, :Monday, :Tuesday, :Wednesday).should == :Monday
      expect { dehasher.enum(:symbolic, :nope) }.to raise_error(WrongTypeError)
    end
  end

  it 'detects missing attributes' do
    expect { dehasher.string(:missing) }.to raise_error(MissingAttributesError)
  end

  it 'detects extra attributes' do
    expect do
      Dehasher.dehash(hash) do |h|
        h.integer(:numeric)
        h.string(:text)
        h.time(:day)
      end
    end.to raise_error(ExtraAttributesError)
  end
end
