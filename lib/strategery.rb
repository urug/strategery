# First, the dependencies
require 'rubygems'
require 'yaml'

# Next the extensions
Dir.glob("#{File.dirname(__FILE__)}/ext/**/*.rb").each { |file| require file }

# Next, load the strategery
Dir.glob("#{File.dirname(__FILE__)}/strategery/**/*.rb").each { |file| require file }

# Finally, formally instantiate the configuration
module SVM
  def self.config
    # Run once
    if not @config
      @config = File.read('config.rb') rescue "SVM::Configurator.run"
      eval(@config)
    end
  end
end

SVM.config
