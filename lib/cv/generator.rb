require 'rexml/document'
require_relative 'object_model'
require_relative 'parser'
require_relative 'pdf_generator'
require_relative 'txt_generator'
require_relative 'html_generator'

module Cv

  class Generator
    attr_reader :input_file
    attr_reader :output_file
    attr_reader :format
    attr_reader :generators

    def initialize(input_file, output_file, format)
      @input_file = input_file
      @output_file = output_file
      @format = format
      @generators = { "pdf" => PdfGenerator.new, "html" => HtmlGenerator.new, "txt" => TxtGenerator.new }
    end

    def generate
      f = File.open(input_file)
      xml = REXML::Document.new(f)
      cv_xml = xml.root
      cv = Cv::CvDocument.build(cv_xml)

      generator = generators[format]

      generator.generate output_file, cv
    end
  end
end