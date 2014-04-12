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
