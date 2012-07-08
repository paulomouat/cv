#encoding: utf-8

require 'prawn'

module Cv

  class PdfGenerator
    attr_reader :filename
    attr_reader :cv_document
    attr_reader :pdf

    def initialize(filename, cv_document)
      @filename = filename
      @cv_document = cv_document
    end

    def generate
      @pdf = Prawn::Document.new
      pdf.font "Times-Roman"
      pdf.font_size 11
      write_candidate_data
      write_profile_data
      write_employment_data
      write_technical_skills_data
      write_education_data
      write_other_sections_data
      pdf.render_file filename
    end

    def write_blank_line
      pdf.text " "
    end

    def write_section_title(title)
      write_blank_line
      pdf.font_size(12) do
        pdf.text title, :style => :bold
      end
      write_blank_line
    end

    def write_candidate_data
      candidate = cv_document.candidate
      pdf.text candidate.name, :align => :center, :style => :bold
      pdf.text candidate.address + " • " + candidate.email, :align => :center
    end

    def write_profile_data
      write_section_title "Profile"
      profile = cv_document.profile
      profile.items.each { |item| pdf.text item }
    end

    def write_employment_data
      write_section_title "Employment"
      employment = cv_document.employment
      employment.companies.each { |company| write_company_data company }
    end

    def write_company_data(company)
      entry_title = "#{company.name} (#{company.location}), #{company.start}-#{company.end}, #{company.title}"
      pdf.text entry_title, :style => :bold
      company.projects.each { |project| write_project_data project }
    end

    def write_project_data(project)
      if project.name.to_s != '' and project.technology.to_s != ''
        entry_title = "#{project.name} (#{project.technology})."
        pdf.text entry_title
      end
      project.items.each { |item| pdf.text item }
    end

    def write_technical_skills_data
      technical_skills = cv_document.technical_skills
      write_section_title technical_skills.header
      technical_skills.skills.each { |skill| write_skill_data skill }
    end

    def write_skill_data(skill)
      pdf.text skill.name, :style => :bold
      skill.items.each { |item| pdf.text item }
    end

    def write_education_data
      write_section_title "Education"
      education = cv_document.education
      education.periods.each { |period| write_period_data period }
    end

    def write_period_data(period)
      entry_title = "#{period.start}-#{period.end}: #{period.location}"
      pdf.text entry_title, :style => :bold
      period.plain_items.each { |item| pdf.text item }
    end

    def write_other_sections_data
      cv_document.other_sections.sections.each do |section|
        write_section_title section.name
        section.plain_items.each { |item| pdf.text item }
      end
    end
  end

end