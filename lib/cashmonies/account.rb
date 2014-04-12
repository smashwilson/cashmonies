module Transaction

  class Account
    attr_accessor :name, :lastfour, :kind

    def to_h
      {
        'name' => @name,
        'lastfour' => @lastfour,
        'kind' => @kind
      }
    end
  end

end
