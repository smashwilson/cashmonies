require 'yaml'

module Cashmonies
  # Load and store Transaction data from a filesystem hierarchy.
  class Storage
    def load_transactions(file)
      YAML.load_file(file).map { |h| Transaction.from_h h }
    end
  end
end
