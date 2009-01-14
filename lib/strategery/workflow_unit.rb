module SVM #:nodoc:
  
  # A WorkflowUnit is a simple unit of work with process as the only
  # method and repository publicly accessible.  It receives and returns a
  # repository which may be the same or a different repository.  If it's
  # the same one, likely the repository will have changed. 
  module WorkflowUnit

    attr_reader :repository
    def process(repository, opts={})
      raise NotImplemented
      return repository
    end
  end
  
  class CrossValidateWorkflowUnit
    include WorkflowUnit
    
    # opts needs to include :times, which will do an n-fold validation on
    # the data.  Defaults to 5.
    def process(repository, opts={})
      n = (opts[:times] || 5)
      
      partitions = repository.partition(n)

      n.times do |i|
        repository.cross_validate(partions[])
      end
      
    end
  end
  
  class ScaleWorkflowUnit
    include WorkflowUnit
    
    def process(repository, opts={})
      repository.scale
    end
  end
  
  class TrainWorkflowUnit
    include WorkflowUnit
    def process(repository, opts={})
    end
  end
  
  class TestWorkflowUnit
    include WorkflowUnit
    def process(repository, opts={})
    end
  end
  
end