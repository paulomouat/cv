#encoding: utf-8

require 'builder'
# require 'stylish'

module Cv

  class HtmlGenerator
    attr_reader :filename
    attr_reader :cv_document
    attr_reader :html

    def generate(filename, cv_document)
      @filename = filename
      @cv_document = cv_document
      @html = Builder::XmlMarkup.new(:indent => 4)
      html.declare! :DOCTYPE, :HTML, :PUBLIC, "-//W3C//DTD HTML 4.01 Transitional//EN", "http://www.w3.org/TR/html4/loose.dtd"
      html.html do
        write_head
        write_body
      end
      File.open(filename, 'w') do |f|
        f.puts html.target!
      end
    end

    private

    def write_head
      html.head do
        html.meta :'http-equiv' => "Content-type", :content => "text/html;charset=UTF-8"
        write_stylesheet
        html.title "Resume - " + cv_document.contact.name
      end
    end

    def write_stylesheet
      #style = Stylish.generate do
      #  rule ".contact-name", font_weight: "bold", text_align: "center"
      #  rule ".contact-info", text_align: "center"
      #  rule ".company-header", font_weight: "bold"
      #  rule ".skill-header", font_weight: "bold"
      #  rule ".period-header", font_weight: "bold"
      #  rule "body", width: "800px"
      #  rule "ul", margin_top: "0px", margin_bottom: "0px", padding_top: "0px", padding_bottom: "0px"
      #end

      #indent = ' ' * 8
      #style.rules.each do |rule|
      #  rule.format = "#{indent}%s\n#{indent}{\n#{indent}    %s\n#{indent}}\n"
      #  rule.declarations.format = "\n#{indent}    "
      #end

      #html.style :type => "text/css" do
      #  html << style.to_s
      #end
      html << '            <style type="text/css">
                .contact-name
                {
                    font-weight:bold;
                    text-align:center;
                }
                .contact-info
                {
                    text-align:center;
                }
                .company-header
                {
                    font-weight:bold;
                }
                .skill-header
                {
                    font-weight:bold;
                }
                .period-header
                {
                    font-weight:bold;
                }
                body
                {
                    width:800px;
                }
                ul
                {
                    margin-top:0px;
                    margin-bottom:0px;
                    padding-top:0px;
                    padding-bottom:0px;
                }
            </style>
'
    end

    def write_body
      html.body do
        html.div :id => 'content' do
          write_contact_data
          write_profile_data
          write_employment_data
          write_technical_skills_data
          write_education_data
          write_other_sections_data
        end
      end
    end

    def write_line(text)
      html.div text
    end

    def write_section_title(title)
      html.h3 title
    end

    def write_contact_data
      contact = cv_document.contact
      html.div :id => 'contact' do
        html.div contact.name, :class => 'contact-name'
        html.div contact.address + " • " + contact.state + " • " + contact.email, :class => 'contact-info'
      end
    end

    def write_profile_data
      html.div :id => 'profile' do
        write_section_title "Profile"
        profile = cv_document.profile
        html.ul do
          profile.items.each { |item| write_bullet_item item }
        end
      end
    end

    def write_employment_data
      html.div :id => 'employment' do
        write_section_title "Employment"
        employment = cv_document.employment
        html.div :id => 'companies' do
          employment.companies.each { |company| write_company_data company }
        end
      end
    end

    def write_company_data(company)
      html.div :class => 'company' do
        entry_title = "#{company.name} (#{company.location}), #{company.start}-#{company.end}, #{company.title}"
        html.div entry_title, :class => 'company-header'
        html.div :id => 'projects' do
          company.projects.each { |project| write_project_data project }
        end
      end
    end

    def write_project_data(project)
      html.div :class => 'project' do
        if project.name.to_s != '' and project.technology.to_s != ''
          entry_title = "Project: #{project.name} (#{project.technology})."
          html.div entry_title, :class => 'project-header'
        end
        html.ul do
          project.items.each { |item| write_bullet_item item }
        end
      end
    end

    def write_technical_skills_data
      html.div :id => 'technical-skills' do
        technical_skills = cv_document.technical_skills
        write_section_title technical_skills.header
        html.div :id => 'skills' do
          technical_skills.skills.each { |skill| write_skill_data skill }
        end
      end
    end

    def write_skill_data(skill)
      html.div :class => 'skill' do
        html.div skill.name, :class => 'skill-header'
        html.ul do
          skill.items.each { |item| write_bullet_item item }
        end
      end
    end

    def write_education_data
      html.div :id => 'education' do
        write_section_title "Education"
        education = cv_document.education
        html.div :id => 'periods' do
          education.periods.each { |period| write_period_data period }
        end
      end
    end

    def write_period_data(period)
      html.div :class => period do
        entry_title = "#{period.start}-#{period.end}: #{period.location}"
        html.div entry_title, :class => 'period-header'
        period.items.each { |item| write_plain_item item }
      end
    end

    def write_other_sections_data
      html.div :id => 'other-sections' do
        cv_document.other_sections.sections.each do |section|
          html.div :class => 'section' do
            write_section_title section.name
            section.items.each { |item| write_plain_item item }
          end
        end
      end
    end

    def write_bullet_item(item)
      html.li item.chomp
    end

    def write_plain_item(item)
      write_line item
    end

  end
end