require 'bundler/gem_tasks'
require 'rake/testtask'

task :default => [ :test ]

Rake::TestTask.new do |t|
  t.libs.push 'lib' << 'spec'
  t.test_files = FileList['spec/*_spec.rb', 'spec/helper.rb']
  t.verbose = true
end