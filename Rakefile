require "rake/testtask"

test_files = Dir.glob("test/**/*_test.rb")

desc "Default Task"
task default: :test

task :package

# Run the unit tests
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = test_files

  t.warning = true
  t.verbose = true
  t.ruby_opts = ["--dev"] if defined?(JRUBY_VERSION)
end
