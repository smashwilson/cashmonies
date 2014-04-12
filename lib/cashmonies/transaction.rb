require 'securerandom'

module Cashmonies
  # Money going into or leaving a particular Account.
  class Transaction
    attr_accessor :timestamp, :code, :description, :amount
    attr_reader :uuid

    def initialize(uuid = nil)
      @uuid = uuid || SecureRandom.uuid
    end

    def <=>(other)
      @timestamp <=> other.timestamp
    end

    def to_h
      {
        'uuid' => @uuid,
        'timestamp' => @timestamp.strftime('%Y-%m-%d'),
        'code' => @code.to_s,
        'description' => @description,
        'amount' => @amount
      }
    end

    def self.from_h(hash)
      Dehasher.dehash(hash) do |h|
        Transaction.new(h.string(:uuid)).tap do |t|
          t.timestamp = h.time(:timestamp)
          t.code = h.symbol(:code)
          t.description = h.string(:description)
          t.amount = h.integer(:amount)
        end
      end
    end
  end
end
