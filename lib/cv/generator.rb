require 'rexml/document'
require_relative 'object_model'
require_relative 'parser'
require_relative 'pdf_generator'
require_relative 'txt_generator'
require_relative 'html_generator'

f = File.open("../../data/PauloMouatResume.xml")
xml = REXML::Document.new(f)
cv_xml = xml.root
cv = Cv::CvDocument.build(cv_xml)

pdf_generator = Cv::PdfGenerator.new("output.pdf", cv)
pdf_generator.generate

txt_generator = Cv::TxtGenerator.new("output.txt", cv)
txt_generator.generate

html_generator = Cv::HtmlGenerator.new("output.html", cv)
html_generator.generate

`open output.pdf`
`open output.txt`
`open output.html`