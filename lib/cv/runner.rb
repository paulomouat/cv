require_relative 'generator'
require_relative 'options'

module Cv
  class Runner
    attr_reader :options

    def initialize(argv)
      @options = Options.new(argv)
    end

    def run
      generator = Generator.new(options.input_file, options.output_file, options.format_spec)
      generator.generate
    end
  end
end