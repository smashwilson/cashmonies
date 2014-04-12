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
    expect(dehasher.string('text')).to eq('blerp')
  end

  it 'allows access by Symbol' do
    expect(dehasher.string(:text)).to eq('blerp')
  end

  describe 'type constraints' do
    it 'constrains to an Integer' do
      expect(dehasher.integer(:numeric)).to eq(1234)
      expect { dehasher.integer(:text) }.to raise_error(WrongTypeError)
    end

    it 'constrains to a date' do
      expect(dehasher.time(:day)).to eq(Time.new(2014, 1, 2))
      expect { dehasher.time(:text) }.to raise_error(WrongTypeError)
    end

    it 'constrains to a symbol' do
      expect(dehasher.symbol(:symbolic)).to eq(:Monday)
    end

    it 'constrains to an enum' do
      expect(dehasher.enum(:symbolic, :Monday, :Tuesday, :Wednesday)).to eq(:Monday)
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
