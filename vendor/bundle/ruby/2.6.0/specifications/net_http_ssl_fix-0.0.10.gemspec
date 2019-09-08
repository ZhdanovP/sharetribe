# -*- encoding: utf-8 -*-
# stub: net_http_ssl_fix 0.0.10 ruby lib

Gem::Specification.new do |s|
  s.name = "net_http_ssl_fix".freeze
  s.version = "0.0.10"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Chris Peters".freeze]
  s.date = "2018-04-07"
  s.description = "Get rid of this lovely error for good, especially on Windows: `SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed`".freeze
  s.email = "chris@minimalorange.com".freeze
  s.homepage = "https://github.com/liveeditor/net_http_ssl_fix".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Community-updated Net::HTTP certificate authority file hack. Very useful for authoring HTTP clients that must run on Ruby + Windows.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, ["~> 11.1.2"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.4.0"])
    else
      s.add_dependency(%q<rake>.freeze, ["~> 11.1.2"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.4.0"])
    end
  else
    s.add_dependency(%q<rake>.freeze, ["~> 11.1.2"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.4.0"])
  end
end
