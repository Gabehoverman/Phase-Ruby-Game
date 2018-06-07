# -*- encoding: utf-8 -*-
# stub: bootswatch-rails 3.3.5 ruby lib

Gem::Specification.new do |s|
  s.name = "bootswatch-rails"
  s.version = "3.3.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Maxim Chernyak", "Esteban Arango Medina"]
  s.date = "2015-06-22"
  s.description = "Bootswatches converted to SCSS ready to use in Rails asset pipeline."
  s.email = ["max@bitsonnet.com", "marranoparael31@gmail.com"]
  s.homepage = "http://github.com/maxim/bootswatch-rails"
  s.rubygems_version = "2.4.6"
  s.summary = "Bootswatches in your Rails asset pipeline"

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, [">= 3.1"])
    else
      s.add_dependency(%q<railties>, [">= 3.1"])
    end
  else
    s.add_dependency(%q<railties>, [">= 3.1"])
  end
end
