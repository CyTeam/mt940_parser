# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "mt940_parser"
  s.version = "1.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Thies C. Arntzen", "Phillip Oertel"]
  s.date = "2012-04-18"
  s.email = "developers@betterplace.org"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".specification",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION.yml",
    "docs/0E0Y00DNY.pdf",
    "docs/FinTS_4.0_Formals.pdf",
    "docs/FinTS_4.0_Messages_Finanzdatenformate.pdf",
    "docs/MT940_Deutschland_Structure2002.pdf",
    "docs/SEPA_20MT940__Schnittstellenbeschreibung.pdf",
    "docs/mt940.pdf",
    "docs/swift_mt940_942.pdf",
    "docs/uebersicht_der_geschaeftsvorfallcodes_und_buchungs_textschluessel.pdf",
    "lib/mt940.rb",
    "lib/mt940/customer_statement_message.rb",
    "mt940_parser.gemspec",
    "test/fixtures/currency_in_25.txt",
    "test/fixtures/currency_in_25.yml",
    "test/fixtures/empty_86.txt",
    "test/fixtures/empty_86.yml",
    "test/fixtures/empty_entry_date.txt",
    "test/fixtures/empty_entry_date.yml",
    "test/fixtures/empty_line.txt",
    "test/fixtures/empty_line.yml",
    "test/fixtures/missing_crlf_at_end.txt",
    "test/fixtures/missing_crlf_at_end.yml",
    "test/fixtures/sepa_mt9401.txt",
    "test/fixtures/sepa_mt9401.yml",
    "test/fixtures/sepa_snippet.txt",
    "test/fixtures/sepa_snippet_broken.txt",
    "test/fixtures/with_binary_character.txt",
    "test/fixtures/with_binary_character.yml",
    "test/helper.rb",
    "test/test_customer_statement_message.rb",
    "test/test_mt940.rb"
  ]
  s.homepage = "http://github.com/betterplace/mt940_parser"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.21"
  s.summary = "MT940 parses account statements in the SWIFT MT940 format."
  s.test_files = [
    "test/helper.rb",
    "test/test_customer_statement_message.rb",
    "test/test_mt940.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.3.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

