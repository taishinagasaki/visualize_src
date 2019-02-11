require "bundler/setup"
require "visualize_ruby"

ruby_code = <<~RUBY
	if are_you_ruby_?
		"wow"
	else
		"owo"
	end
RUBY

results = VisualizeRuby::Builder.new(ruby_code: ruby_code).build
VisualizeRuby::Graphviz.new(results).to_graph(path: "example_hama.png")
