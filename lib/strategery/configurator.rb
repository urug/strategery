module SVM #:nodoc:
  class Configurator
    class << self
      def run(&block)
        SVM.instance_eval(&block) if block_given?
      end
    end
  end
end