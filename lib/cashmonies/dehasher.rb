module Cashmonies

  class WrongTypeError < RuntimeError
  end

  class MissingAttributesError < RuntimeError
  end

  class ExtraAttributesError < RuntimeError
  end

  class Dehasher
    attr_reader :handled

    def initialize(hash)
      @hash = hash
      @handled = []
    end

    def string(key)
      raw(key).to_s
    end

    def integer(key)
      typed(key, Integer)
    end

    def time(key)
      str = string(key)
      m = str.match /^(\d{4})-(\d{2})-(\d{2})$/
      raise WrongTypeError.new unless m
      Time.new(m[1].to_i, m[2].to_i, m[3].to_i)
    end

    def symbol(key)
      raw(key).to_sym
    end

    def enum(key, *valid)
      symbol(key).tap do |sym|
        raise WrongTypeError.new unless valid.include? sym
      end
    end

    def self.dehash(hash)
      dehasher = new(hash)
      result = yield dehasher
      remaining = hash.keys.map(&:to_sym) - dehasher.handled
      raise ExtraAttributesError.new unless remaining.empty?
      result
    end

    private

    def raw(key)
      handled << key.to_sym
      @hash[key.to_s] || @hash[key.to_sym] || begin
        raise MissingAttributesError.new
      end
    end

    def typed(key, klass)
      raw(key).tap do |raw|
        raise WrongTypeError.new unless raw.kind_of? klass
      end
    end
  end

end
