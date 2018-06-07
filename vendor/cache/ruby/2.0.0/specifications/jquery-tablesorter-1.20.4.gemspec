# -*- encoding: utf-8 -*-
# stub: jquery-tablesorter 1.20.4 ruby lib

Gem::Specification.new do |s|
  s.name = "jquery-tablesorter"
  s.version = "1.20.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jun Lin", "Erik-B. Ernst"]
  s.date = "2016-02-18"
  s.description = "Simple integration of jquery-tablesorter (Mottie's fork) into the Rails asset pipeline."
  s.email = ["github@black-milk.de"]
  s.homepage = "https://github.com/themilkman/jquery-tablesorter-rails"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.rubygems_version = "2.4.6"
  s.summary = "Simple integration of jquery-tablesorter (Mottie's fork) into the Rails asset pipeline."

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, ["< 6", ">= 3.2"])
    else
      s.add_dependency(%q<railties>, ["< 6", ">= 3.2"])
    end
  else
    s.add_dependency(%q<railties>, ["< 6", ">= 3.2"])
  end
end
