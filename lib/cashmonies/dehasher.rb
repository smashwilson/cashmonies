module Cashmonies
  class WrongTypeError < RuntimeError
  end

  class MissingAttributesError < RuntimeError
  end

  class ExtraAttributesError < RuntimeError
  end

  # Deserialization helper for model classes' #from_h methods. Enforces types and expected hash
  # keys.
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
      m = str.match(/^(\d{4})-(\d{2})-(\d{2})$/)
      fail WrongTypeError, "#{key} must be a date in YYYY-MM-DD format, was <#{str}>" unless m
      Time.new(m[1].to_i, m[2].to_i, m[3].to_i)
    end

    def symbol(key)
      raw(key).to_sym
    end

    def enum(key, *valid)
      symbol(key).tap do |sym|
        unless valid.include? sym
          fail WrongTypeError, "#{key} must be one of #{valid.join ', '}, was '#{sym}'"
        end
      end
    end

    def self.dehash(hash)
      dehasher = new(hash)
      result = yield dehasher
      remaining = hash.keys.map(&:to_sym) - dehasher.handled
      unless remaining.empty?
        fail ExtraAttributesError, "Unrecognized attributes: #{remaining.join ', '}"
      end
      result
    end

    private

    def raw(key)
      handled << key.to_sym
      @hash[key.to_s] || @hash[key.to_sym] || begin
        fail MissingAttributesError, "Missing required attribute: <#{key}>"
      end
    end

    def typed(key, klass)
      raw(key).tap do |raw|
        unless raw.kind_of? klass
          fail WrongTypeError, "Wrong type: expected #{klass}, got #{raw.inspect}"
        end
      end
    end
  end
end
