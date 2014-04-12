$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'cashmonies'

include Cashmonies

FIXTURE_DIR = File.join(__dir__, 'fixtures')

def fixture_path(*args)
  File.join(FIXTURE_DIR, *args)
end
