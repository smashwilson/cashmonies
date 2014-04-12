require 'securerandom'

module Cashmonies

  class Transaction
    attr_accessor :timestamp, :code, :description, :amount
    attr_reader :uuid

    def initialize(uuid = nil)
      @uuid = uuid || SecureRandom.uuid
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
      Transaction.new(hash['uuid']).tap do |t|
        t.timestamp = Time.parse(hash['timestamp'])
        t.code = hash['code'].to_sym
        t.description = hash['description']
        t.amount = hash['amount'].to_i
      end
    end
  end

end
