module SVM #:nodoc:
  class Workflow
    class << self
      def instance(name)
        @@inst ||= {}
        @@inst[name]
      end
    end
    
    # Scpping...
    def process(name)
      self.instance[:name].each do |unit|
        unit.process
      end
    end
  end
  
  Workflow.instance[:default] = [
    ScaleWorkflowUnit.new,
    TrainWorkflowUnit.new,
    ScaleWorkflowUnit.new,
    TestWorkflowUnit.new,
    CrossValidateWorkflowUnit.new
  ]
end