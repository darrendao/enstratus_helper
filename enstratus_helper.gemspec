Gem::Specification.new do |s|
  s.name = %q{enstratus_helper}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Darren Dao"]
  s.date = %q{2011-12-07}
  s.email = %q{darrendao@gmail.com}
  s.files = ["README.md", "lib/enstratus_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/darrendao/enstratus_helper}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Simple ruby wrapper to make it easier to talk to enStratus API }
  s.add_runtime_dependency 'rest-client'

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
