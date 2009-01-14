require 'couch_rest'

module SVM #:nodoc:
  class CouchDbRepository # subclass CouchRest?
    # ... define the default  Make this a module??
    include Repository
  end
end