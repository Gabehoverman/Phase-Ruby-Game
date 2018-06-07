# -*- encoding: utf-8 -*-
# stub: phaser-rails 2.4.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "phaser-rails"
  s.version = "2.4.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Sungjin Han"]
  s.date = "2016-02-18"
  s.description = "Phaser(http://phaser.io), HTML5 game framework for Rails"
  s.email = ["meinside@gmail.com"]
  s.homepage = "https://github.com/meinside/phaser-rails"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.6"
  s.summary = "Phaser, HTML5 game framework for Rails"

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, [">= 4.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.5"])
      s.add_development_dependency(%q<rake>, ["~> 0.8"])
    else
      s.add_dependency(%q<railties>, [">= 4.0"])
      s.add_dependency(%q<bundler>, ["~> 1.5"])
      s.add_dependency(%q<rake>, ["~> 0.8"])
    end
  else
    s.add_dependency(%q<railties>, [">= 4.0"])
    s.add_dependency(%q<bundler>, ["~> 1.5"])
    s.add_dependency(%q<rake>, ["~> 0.8"])
  end
end
