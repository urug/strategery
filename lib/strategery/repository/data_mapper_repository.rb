require 'data_mapper'

module SVM #:nodoc:
  class DataMapperRepository
    include DataMapper
    include Repository
  end
end