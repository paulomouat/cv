require 'rexml/document'
require_relative 'objectmodel'
require_relative 'parser'

f = File.open("../../data/PauloMouatResume.xml")
xml = REXML::Document.new(f)
cv_xml = xml.root
cv = Cv::CvDocument.build(cv_xml)

puts cv
