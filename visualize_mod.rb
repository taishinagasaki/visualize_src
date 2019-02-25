require "bundler/setup"
require "visualize_ruby"
require "fileutils"

module Visualize

def visualize(ruby_code)

FileUtils.rm("/var/www/cgi-bin/source_code.png") if File.exist?("/var/www/cgi-bin/source_code.png")
results = VisualizeRuby::Builder.new(ruby_code: ruby_code).build
VisualizeRuby::Graphviz.new(results).to_graph(path: "source_code.png")

end
module_function :visualize
end
