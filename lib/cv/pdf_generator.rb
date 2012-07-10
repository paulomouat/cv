#encoding: utf-8

require 'prawn'

module Cv

  class PdfGenerator
    attr_reader :filename
    attr_reader :cv_document
    attr_reader :pdf

    DPI = 72

    def initialize(filename, cv_document)
      @filename = filename
      @cv_document = cv_document
    end

    def generate
      @pdf = Prawn::Document.new(:margin => get_margins)
      apply_global_formatting(pdf)
      write_contact_data
      write_profile_data
      write_employment_data
      write_technical_skills_data
      write_education_data
      write_other_sections_data
      apply_page_numbers(pdf)
      pdf.render_file filename
    end

  private

    def get_margins
      left_margin = DPI * 0.75
      right_margin = DPI * 0.75
      top_margin = DPI * 0.75
      bottom_margin = DPI * 1
      [top_margin, right_margin, bottom_margin, left_margin]
    end

    def apply_global_formatting(pdf)
      pdf.font "Times-Roman"
      pdf.font_size 11
      pdf.default_leading 1
    end

    def apply_page_numbers(pdf)
      options = {}
      options[:page_filter] = lambda { |page_number| page_number > 1 }
      options[:start_count_at] = 2
      options[:at] = [pdf.bounds.right - 200, -20]
      options[:width] = 200
      options[:align] = :right
      pdf.font("Helvetica") do
        pdf.font_size(9) do
          pdf.number_pages "Resume - #{cv_document.contact.name} - <page>", options
        end
      end
    end

    def write_blank_line
      pdf.text " "
    end

    def write_section_title(title)
      pdf.pad_top(12) do
        pdf.pad_bottom(7) do
          pdf.font_size(13) do
            pdf.text title, :style => :bold
          end
        end
      end
    end

    def write_contact_data
      contact = cv_document.contact
      pdf.text contact.name, :align => :center, :style => :bold
      pdf.text contact.address + " • " + contact.state + " • " + contact.email, :align => :center
    end

    def write_profile_data
      write_section_title "Profile"
      profile = cv_document.profile
      profile.items.each { |item| write_bullet_item item }
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
        entry_title = "Project: #{project.name} (#{project.technology})."
        pdf.text entry_title
      end
      project.items.each { |item| write_bullet_item item }
    end

    def write_technical_skills_data
      technical_skills = cv_document.technical_skills
      write_section_title technical_skills.header
      technical_skills.skills.each { |skill| write_skill_data skill }
    end

    def write_skill_data(skill)
      pdf.text skill.name, :style => :bold
      skill.items.each { |item| write_bullet_item item }
    end

    def write_education_data
      write_section_title "Education"
      education = cv_document.education
      education.periods.each { |period| write_period_data period }
    end

    def write_period_data(period)
      entry_title = "#{period.start}-#{period.end}: #{period.location}"
      pdf.text entry_title, :style => :bold
      period.items.each { |item| write_plain_item item }
    end

    def write_other_sections_data
      cv_document.other_sections.sections.each do |section|
        write_section_title section.name
        section.items.each { |item| write_plain_item item }
      end
    end

    def write_bullet_item(item)
      pdf.indent(35) do
        pdf.float do
          pdf.indent(-18) do
            pdf.text "•"
          end
        end
        pdf.text item
      end
    end

    def write_plain_item(item)
      pdf.text item
    end
  end

end