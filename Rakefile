require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = 'mt940_parser'
    gem.summary = %(MT940 parses account statements in the SWIFT MT940 format.)
    gem.license = 'MIT'
    gem.email = 'developers@betterplace.org'
    gem.homepage = 'http://github.com/betterplace/mt940_parser'
    gem.authors = ['Thies C. Arntzen', 'Phillip Oertel']
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts 'Jeweler (or a dependency) not available. Install it with: gem install jeweler'
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:rspec) do |t|
  t.rspec_opts = '--color --format documentation'
end

desc 'Run all specs with rcov'
RSpec::Core::RakeTask.new(:rcov) do |t|
  t.rspec_opts = '--color --format documentation'
  t.rcov = true
  t.rcov_opts = '--exclude /gems/,spec'
end

task default: :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ''

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "mt940 #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
