module Cv

  class Contact < Struct.new(:name, :address, :state, :email)
  end

  class Profile < Struct.new(:items)
  end

  class Project < Struct.new(:name, :technology, :items)
  end

  class Company < Struct.new(:name, :location, :start, :end, :title, :projects)
  end

  class Employment < Struct.new(:companies)
  end

  class TechnicalSkills < Struct.new(:header, :skills)
  end

  class Skill < Struct.new(:name, :items)
  end

  class Education < Struct.new(:periods)
  end

  class Period < Struct.new(:start, :end, :location, :items)
  end

  class OtherSections < Struct.new(:sections)
  end

  class Section < Struct.new(:name, :items)
  end

  class CvDocument < Struct.new(:contact, :profile, :employment, :technical_skills, :education, :other_sections)
  end
end