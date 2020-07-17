# frozen_string_literal: true

Gem::Specification.new do |spec|
    spec.name          = "unidata-jekyll-theme"
    spec.version       = "0.0.1"
    spec.authors       = ["Unidata"]
    spec.email         = ["plaza@unidata.ucar.edu"]
  
    spec.summary       = "A jekyll theme for Unidata projects. Based on https://idratherbewriting.com/documentation-theme-jekyll"
    spec.homepage      = "https://github.com/unidata/unidata-jekyll-theme"
    spec.license       = "MIT"
  
    spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(_includes|_layouts|assets|licenses|README|_config\.yml)!i) }
  
    spec.add_runtime_dependency "jekyll", ">= 3.8", "< 4.2"
  end
  
