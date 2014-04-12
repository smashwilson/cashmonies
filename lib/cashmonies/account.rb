module Cashmonies

  class Account
    attr_accessor :name, :lastfour, :kind

    def to_h
      {
        'name' => @name,
        'lastfour' => @lastfour,
        'kind' => @kind
      }
    end

    def self.from_h(hash)
      Account.new.tap do |a|
        a.name = hash['name']
        a.lastfour = hash['lastfour']
        a.kind = hash['kind'].to_sym
      end
    end
  end

end
