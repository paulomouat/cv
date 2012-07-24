require 'optparse'

module Cv
  class Options
    attr_reader :input_file
    attr_reader :output_file
    attr_reader :format_spec

    def initialize(argv)
      parse(argv)
    end

  private

    def parse(argv)
      OptionParser.new do |opts|
        opts.banner = "Usage: cv -i input_file -f format_spec -o output_file"
        opts.on("-i", "--input input_file", String, "The XML file to use as input") do |input_file|
          @input_file = input_file
        end
        opts.on("-f", "--format format_spec", String, "The format for the output file") do |format_spec|
          @format_spec = format_spec
        end
        opts.on("-o", "--output output_file", String, "The output file") do |output_file|
          @output_file = output_file
        end
        opts.on("-h", "--help", "Show this message") do
          puts opts
          exit
        end
        begin
          argv = ["-h"] if argv.empty?
          opts.parse!(argv)
        rescue OptionParser::ParseError => e
          STDERR.puts e.message, "\n", opts
          exit(-1)
        end
      end
    end

  end
end