require 'optparse'

module Cv
  class Options
    attr_reader :xml_resume
    attr_reader :output_filename

    def initialize(argv)
      parse(argv)
    end

  private

    def parse(argv)
      OptionParser.new do |opts|
        opts.banner = "Usage: anagram [ options ] word..."
        opts.on("-d", "--dict path", String, "Path to dictionary") do |dict|
          @dictionary = dict
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