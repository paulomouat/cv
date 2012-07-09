require 'rexml/document'
require_relative 'object_model'
require_relative 'parser'
require_relative 'pdf_generator'

f = File.open("../../data/PauloMouatResume.xml")
xml = REXML::Document.new(f)
cv_xml = xml.root
cv = Cv::CvDocument.build(cv_xml)

pdf_generator = Cv::PdfGenerator.new("output.pdf", cv)
pdf_generator.generate

`open output.pdf`