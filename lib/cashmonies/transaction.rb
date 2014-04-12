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
        uuid: @uuid,
        timestamp: @timestamp.strftime('%Y-%m-%d'),
        code: @code.to_s,
        description: @description,
        amount: @amount
      }
    end
  end

end
