#encoding: utf-8

module Cv

  class TxtGenerator
    attr_reader :filename
    attr_reader :cv_document
    attr_reader :txt

    LINE_LENGTH = 80
    INDENT = 4

    def initialize(filename, cv_document)
      @filename = filename
      @cv_document = cv_document
    end

    def generate
      @txt = ""
      write_contact_data
      write_profile_data
      write_employment_data
      write_technical_skills_data
      write_education_data
      write_other_sections_data
      File.open(filename, 'w') do |f|
        f.puts txt
      end
    end

    private

    def word_wrap(text, col_width = LINE_LENGTH)
      text.gsub!( /(\S{#{col_width}})(?=\S)/, '\1 ' )
      text.gsub!( /(.{1,#{col_width}})(?:\s+|$)/, "\\1\n" )
      text
    end

    def format_paragraph(text, indent = 0, wrap = false)
      result = wrap ? word_wrap(text, LINE_LENGTH - indent) : text
      if indent > 0
        indented = ""
        result.lines.each do |line|
          indented << ' ' * indent
          indented << line
        end
        result = indented
      end
      result
    end

    def write_line(text)
      @txt << text
      @txt << "\n" unless text[-1, 1] == "\n"
    end

    def write_blank_line
      write_line ""
    end

    def write_emphasised_line(text)
      write_blank_line
      write_line text
    end

    def write_section_title(title)
      write_blank_line
      write_line title
      write_blank_line
    end

    def write_contact_data
      contact = cv_document.contact
      write_line contact.name
      write_line contact.address + " • " + contact.state + " • " + contact.email
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
      write_line entry_title
      company.projects.each { |project| write_project_data project }
    end

    def write_project_data(project)
      if project.name.to_s != '' and project.technology.to_s != ''
        entry_title = "Project: #{project.name} (#{project.technology})."
        write_line entry_title
      end
      project.items.each { |item| write_bullet_item item }
    end

    def write_technical_skills_data
      technical_skills = cv_document.technical_skills
      write_section_title technical_skills.header
      technical_skills.skills.each { |skill| write_skill_data skill }
    end

    def write_skill_data(skill)
      write_line skill.name
      skill.items.each { |item| write_bullet_item item }
    end

    def write_education_data
      write_section_title "Education"
      education = cv_document.education
      education.periods.each { |period| write_period_data period }
    end

    def write_period_data(period)
      entry_title = "#{period.start}-#{period.end}: #{period.location}"
      write_line entry_title
      period.items.each { |item| write_plain_item item }
    end

    def write_other_sections_data
      cv_document.other_sections.sections.each do |section|
        write_section_title section.name
        section.items.each { |item| write_plain_item item }
      end
    end

    def write_bullet_item(item)
      paragraph = format_paragraph item, INDENT, true
      paragraph[2] = "-"
      write_line paragraph
    end

    def write_plain_item(item)
      paragraph = format_paragraph item, INDENT, true
      write_line paragraph
    end

  end
end