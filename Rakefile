require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('svm', '0.1.0') do |p|
  p.description              = "Generate a unique token with Active Record." 
  p.url                      = "http://github.com/davidrichards/svm" 
  p.author                   = "David Richards" 
  p.email                    = "drichards@showcase60.com" 
  p.ignore_pattern           = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
