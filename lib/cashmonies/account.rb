module Cashmonies
  # A place we put or take money from. An Account has many Transactions.
  class Account
    attr_accessor :name, :lastfour, :kind
    attr_reader :transactions

    def initialize
      @transactions = []
    end

    def ordered_transactions
      @transactions.sort
    end

    def transactions_by_month
      current_month = nil
      bucket = []

      ordered_transactions.each do |t|
        current_month = t.timestamp.strftime('%Y-%m') if current_month.nil?
        t_month = t.timestamp.strftime('%Y-%m')

        if current_month != t_month
          # We've crossed a month boundary.
          yield current_month, bucket

          current_month = t_month
          bucket = []
        end

        bucket << t
      end

      yield current_month, bucket unless bucket.empty?
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
