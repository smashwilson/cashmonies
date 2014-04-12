require 'yaml'

module Cashmonies
  # Load and store Transaction data from a filesystem hierarchy.
  class Storage
    def load_transactions(file)
      YAML.load_file(file).map { |h| Transaction.from_h h }
    end

    def load_account(file)
      Account.from_h YAML.load_file(file)
    end
  end
end
