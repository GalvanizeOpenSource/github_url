$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "github_url"
require "pry"

RSpec.configure do |config|
  # config.include GithubUrl::TestHelpers
end
