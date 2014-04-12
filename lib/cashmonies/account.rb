module Cashmonies

  class Account
    attr_accessor :name, :lastfour, :kind
    attr_reader :transactions

    def initialize
      @transactions = []
    end

    def ordered_transactions
      @transactions.sort
    end

    def to_h
      {
        'name' => @name,
        'lastfour' => @lastfour,
        'kind' => @kind
      }
    end

    def self.from_h(hash)
      Dehasher.dehash(hash) do |h|
        Account.new.tap do |a|
          a.name = h.string(:name)
          a.lastfour = h.integer(:lastfour)
          a.kind = h.enum(:kind, :checking, :savings, :debt)
        end
      end
    end
  end

end
