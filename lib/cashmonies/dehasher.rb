module Cashmonies

  class WrongTypeError < RuntimeError
  end

  class Dehasher
    def initialize(hash)
      @hash = hash
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

    private

    def raw(key)
      @hash[key.to_s] || @hash[key.to_sym]
    end

    def typed(key, klass)
      raw(key).tap do |raw|
        raise WrongTypeError.new unless raw.kind_of? klass
      end
    end
  end

end
