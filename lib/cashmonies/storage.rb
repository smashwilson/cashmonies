require 'yaml'

#
module Cashmonies
  ACCOUNT_FILENAME = 'account.yml'

  # Load and store Transaction data from a filesystem hierarchy.
  class Storage
    attr_reader :accounts

    def initialize
      @accounts = []
    end

    def load_transactions(path)
      YAML.load_file(path).map { |h| Transaction.from_h h }
    end

    def store_transactions(transactions, path)
      File.open(path, 'w') do |outf|
        YAML.dump(transactions.map(&:to_h), outf)
      end
    end

    def load_account(path)
      Account.from_h YAML.load_file(path)
    end

    def self.load(root)
      new.tap do |s|
        subdirs(root).each do |adir|
          afile = File.join adir, ACCOUNT_FILENAME
          next unless File.exist? afile

          account = s.load_account(afile)
          s.accounts << account

          subdirs(adir).each do |tdir|
            subfiles(tdir, 'yml').each do |tfile|
              account.transactions.concat s.load_transactions(tfile)
            end
          end
        end
      end
    end

    def self.entries(root, glob)
      Dir[File.join root, glob].sort_by { |e| File.basename(e).gsub(/-/, '').to_i }
    end

    def self.subdirs(root)
      entries(root, '*').select { |e| File.directory? e }
    end

    def self.subfiles(root, extension)
      entries(root, "*.#{extension}").select { |e| File.file? e }
    end
  end
end
