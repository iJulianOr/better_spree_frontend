source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.2.0'

gem 'spree', '~> 3.6.3'
# Provides basic authentication functionality for testing parts of your engine
gem 'spree_auth_devise', '~> 3.3'
gem 'rails-controller-testing'

gem 'rubocop', require: false
gem 'rubocop-rspec', require: false
gem 'webpacker'

gemspec
