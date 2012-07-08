module Cv

  class Candidate
    attr_reader :name
    attr_reader :address
    attr_reader :email

    def initialize(name, address, email)
      @name = name
      @address = address
      @email = email
    end
  end

  class Profile
    attr_reader :items

    def initialize(items)
      @items = items
    end
  end

  class Project
    attr_reader :name
    attr_reader :technology
    attr_reader :items

    def initialize(name, technology, items)
      @name = name
      @technology = technology
      @items = items
    end
  end

  class Company
    attr_reader :name
    attr_reader :location
    attr_reader :start
    attr_reader :end
    attr_reader :title
    attr_reader :projects

    def initialize(name, location, start, _end, title, projects)
      @name = name
      @location = location
      @start = start
      @end = _end
      @title = title
      @projects = projects
    end
  end

  class Employment
    attr_reader :companies

    def initialize(companies)
      @companies = companies
    end
  end

  class TechnicalSkills
    attr_reader :header
    attr_reader :skills

    def initialize(header, skills)
      @header = header
      @skills = skills
    end
  end

  class Skill
    attr_reader :name
    attr_reader :items

    def initialize(name, items)
      @name = name
      @items = items
    end
  end

  class Education
    attr_reader :periods

    def initialize(periods)
      @periods = periods
    end
  end

  class Period
    attr_reader :start
    attr_reader :end
    attr_reader :location
    attr_reader :plain_items

    def initialize(start, _end, location, plain_items)
      @start = start
      @end = _end
      @location = location
      @plain_items = plain_items
    end
  end

  class OtherSections
     attr_reader :sections

    def initialize(sections)
      @sections = sections
    end
  end

  class Section
    attr_reader :name
    attr_reader :plain_items

    def initialize(name, plain_items)
      @name = name
      @plain_items = plain_items
    end

  end

  class CvDocument
    attr_reader :candidate
    attr_reader :profile
    attr_reader :employment
    attr_reader :technical_skills
    attr_reader :education
    attr_reader :other_sections

    def initialize(candidate, profile, employment, technical_skills, education, other_sections)
      @candidate = candidate
      @profile = profile
      @employment = employment
      @technical_skills = technical_skills
      @education = education
      @other_sections = other_sections
    end
  end
end