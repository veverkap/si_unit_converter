require "rake/testtask"

task default: :test

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList["*_test.rb"]
  t.verbose = false
end
