# frozen_string_literal: true

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
end

desc 'Check Ruby code with RuboCop'
task :lint do
  sh 'bundle exec rubocop'
end

desc 'Automatically fix safe RuboCop offenses'
task :fix do
  sh 'bundle exec rubocop -a'
end

desc 'Automatically fix all RuboCop offenses'
task :fix_all do
  sh 'bundle exec rubocop -A'
end

desc 'Build SKK dictionaries'
task :build do
  ruby 'bin/convert'
end

desc 'Remove generated dictionaries'
task :clean do
  rm_rf 'build'
end

desc 'Run tests and lint'
task default: %i[test lint]
