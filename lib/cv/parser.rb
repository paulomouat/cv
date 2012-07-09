require 'rexml/document'
require_relative 'object_model'

module Cv

  class Contact
    def self.build(xml)
      name = xml.attributes["name"]
      contact_info_xml = xml.elements["ContactInfo"]
      address = contact_info_xml.attributes["address"]
      state = contact_info_xml.attributes["state"]
      email = contact_info_xml.attributes["email"]
      Contact.new(name, address, state, email)
    end
  end

  class Profile
    def self.build(xml)
      items = []
      xml.elements.each("Item") { |item| items.push item.text}
      Profile.new(items)
    end
  end

  class Project
    def self.build(xml)
      name = xml.attributes["name"]
      technology = xml.attributes["technology"]
      items = []
      xml.elements.each("Item") { |item| items.push item.text}
      Project.new(name, technology, items)
    end
  end

  class Company
    def self.build(xml)
      name = xml.attributes["name"]
      location = xml.attributes["location"]
      start = xml.attributes["start"]
      _end = xml.attributes["end"]
      title = xml.attributes["title"]
      projects = []
      xml.elements.each("Project") { |project| projects.push Project.build(project) }
      Company.new(name, location, start, _end, title, projects)
    end
  end

  class Employment
    def self.build(xml)
      companies = []
      xml.elements.each("Company") { |company| companies.push Company.build(company) }
      Employment.new(companies)
    end
  end

  class Skill
    def self.build(xml)
      name = xml.attributes["name"]
      items = []
      xml.elements.each("Item") { |item| items.push item.text}
      Skill.new(name, items)
    end
  end

  class TechnicalSkills
    def self.build(xml)
      header = xml.attributes["header"]
      skills = []
      xml.elements.each("Skill") { |skill| skills.push Skill.build(skill) }
      TechnicalSkills.new(header, skills)
    end
  end

  class Period
    def self.build(xml)
      start = xml.attributes["start"]
      _end = xml.attributes["end"]
      location = xml.attributes["location"]
      plain_items = []
      xml.elements.each("PlainItem") { |item| plain_items.push item.text }
      Period.new(start, _end, location, plain_items)
    end
  end

  class Education
    def self.build(xml)
      periods = []
      xml.elements.each("Period") { |period| periods.push Period.build(period) }
      Education.new(periods)
    end
  end

  class Section
    def self.build(xml)
      name = xml.attributes["name"]
      plain_items = []
      xml.elements.each("PlainItem") { |item| plain_items.push item.text }
      Section.new(name, plain_items)
    end
  end

  class OtherSections
    def self.build(xml)
      sections = []
      xml.elements.each("Section") { |section| sections.push Section.build(section) }
      OtherSections.new(sections)
    end
  end

  class CvDocument
    def self.build(xml)
      contact_xml = xml.elements["Contact"]
      contact = Contact.build(contact_xml)
      profile_xml = xml.elements["Profile"]
      profile = Profile.build(profile_xml)
      employment_xml = xml.elements["Employment"]
      employment = Employment.build(employment_xml)
      technical_skills_xml = xml.elements["TechnicalSkills"]
      technical_skills = TechnicalSkills.build(technical_skills_xml)
      education_xml = xml.elements["Education"]
      education = Education.build(education_xml)
      other_sections_xml = xml.elements["OtherSections"]
      other_sections = OtherSections.build(other_sections_xml)
      CvDocument.new(contact, profile, employment, technical_skills, education, other_sections)
    end
  end

end