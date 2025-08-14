# frozen_string_literal: true

Gem::Specification.new do |spec|
    spec.name          = "unidata-jekyll-plugins"
    spec.version       = "0.0.3"
    spec.required_ruby_version = ">= 3.4.5"
    spec.authors       = ["Unidata"]
    spec.email         = ["plaza@unidata.ucar.edu"]

    spec.summary       = "A set of jekyll plugins for Unidata the Unidata Jekyll Theme."
    spec.homepage      = "https://github.com/unidata/unidata-jekyll-theme"
    spec.license       = "MIT"

    all_files     = `git ls-files -z`.split("\x0")
    spec.files       = all_files.grep(%r!^(_plugins)/!)
    spec.require_paths = ["_plugins"]

    spec.add_runtime_dependency "jekyll", "~> 4.4.1"
  end
