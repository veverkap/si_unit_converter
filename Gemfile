source "https://rubygems.org"
ruby "2.4.1"

detected_ruby_version = Gem::Version.new(RUBY_VERSION.dup)
required_ruby_version = Gem::Version.new("2.4.1") # minimum supported version

if detected_ruby_version < required_ruby_version
  fail "RUBY_VERSION must be at least #{required_ruby_version}, " \
       "detected RUBY_VERSION #{RUBY_VERSION}"
end

gem "oj"
gem "puma"
gem "rake"
gem "sinatra"

group :development, :test do
  gem "cane"
  gem "guard"
  gem "guard-minitest"
  gem "guard-rubocop"
  gem "minitest"
  gem "rubocop"
end
