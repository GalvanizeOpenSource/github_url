# GithubUrl

A small ruby gem for parsing Github URLs

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'github_url'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install github_url

## Usage

Initializing a GithubUrl

```ruby
url = GithubUrl.new('https://github.com/GalvanizeOpenSource/github_url/blob/master/lib/github_url.rb')
```

Initializing a GithubUrl using a specific branch

```ruby
url_with_branch = GithubUrl.new('https://github.com/GalvanizeOpenSource/github_url/blob/master/lib/github_url.rb', 'branch-besides-master')
```

Getting the organization

```ruby
url.organization
# GalvanizeOpenSource
```

Getting the repository

```ruby
url.repository
# github_url
```

Getting the branch (will default to master when initialized)

```ruby
url.branch
# master
```

```ruby
url_with_branch.branch
# branch-besides-master
```

Getting the path

```ruby
url.path
# lib/github_url.rb
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/GalvanizeOpenSource/github_url. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GithubUrl project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/GalvanizeOpenSource/github_url/blob/master/CODE_OF_CONDUCT.md).
