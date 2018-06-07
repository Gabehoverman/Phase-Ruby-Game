# -*- encoding: utf-8 -*-
# stub: csv_builder 2.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "csv_builder"
  s.version = "2.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Econsultancy", "Vidmantas Kabosis", "Gabe da Silveira"]
  s.date = "2012-05-24"
  s.description = "CSV template handler for Rails.  Enables :format => 'csv' in controllers, with templates of the form report.csv.csvbuilder."
  s.email = "gabe@websaviour.com"
  s.extra_rdoc_files = ["README.md"]
  s.files = ["README.md"]
  s.homepage = "http://github.com/dasil003/csv_builder"
  s.licenses = ["MIT"]
  s.requirements = ["iconv or Ruby 1.9"]
  s.rubygems_version = "2.4.6"
  s.summary = "CSV template handler for Rails"

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>, [">= 3.0.0"])
      s.add_development_dependency(%q<rails>, [">= 3.0.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.5"])
      s.add_development_dependency(%q<rspec-rails>, ["~> 2.5"])
      s.add_development_dependency(%q<rack>, [">= 0"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
    else
      s.add_dependency(%q<actionpack>, [">= 3.0.0"])
      s.add_dependency(%q<rails>, [">= 3.0.0"])
      s.add_dependency(%q<rspec>, ["~> 2.5"])
      s.add_dependency(%q<rspec-rails>, ["~> 2.5"])
      s.add_dependency(%q<rack>, [">= 0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
    end
  else
    s.add_dependency(%q<actionpack>, [">= 3.0.0"])
    s.add_dependency(%q<rails>, [">= 3.0.0"])
    s.add_dependency(%q<rspec>, ["~> 2.5"])
    s.add_dependency(%q<rspec-rails>, ["~> 2.5"])
    s.add_dependency(%q<rack>, [">= 0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
  end
end
