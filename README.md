# NOTICE: Project is no longer maintained
As of November 7th, 2018, Code42 has chosen to no longer actively host this project.  The project was archive at this point.  All issues have been closed and pull requests rejected.  While archived, the source is still available, but this project may be permanantly removed from GitHub in the near future.

# Code 42 API Ruby Gem [![Build Status](https://travis-ci.org/code42/code42_api_ruby.svg?branch=master)](https://travis-ci.org/code42/code42_api_ruby)

A Ruby interface to the Code 42 API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'code42'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install code42
```

## Configuration

```ruby
client = Code42::Client.new(
  host: 'staging.code42.com',
  port: 1234,
  https: true,
  api_root: '/api/',
  username: 'testuser',
  password: 'letmein'
)
```

### Authentication

```ruby
token = client.get_token
```

Then you can pass this token for further requests:

```ruby
client = Code42::Client.new(
  host: 'staging.code42.com',
  port: 1234,
  https: true,
  api_root: '/api/',
  token: token
)
```

## Resources

### User

attributes:

```ruby
[:id,
 :uid,
 :status,
 :username,
 :email,
 :first_name,
 :last_name,
 :quota_in_bytes,
 :org_id,
 :org_uid,
 :org_name,
 :active,
 :blocked,
 :email_promo,
 :invited,
 :org_type,
 :username_is_an_email,
 :created_at,
 :updated_at]
```

### Org

attributes:

```ruby
[:id,
 :uid,
 :name,
 :status,
 :active,
 :blocked,
 :parent_id,
 :type,
 :external_id,
 :hierarchy_counts,
 :config_inheritance_counts,
 :created_at,
 :updated_at,
 :registration_key,
 :reporting,
 :custom_config,
 :settings,
 :settings_inherited,
 :settings_summary]
```

## Usage

### Ping a host

```ruby
success = client.ping.success?
```

### Fetch the currently authorized API user

```ruby
user = client.user
```

### Fetch a user by ID

```ruby
user = client.user(42)
```

### Fetch the Org for the currently authorized API user

```ruby
org = client.org
```

### Fetch a specific Org by ID

```ruby
org = client.org(42)
```

### Validate a token

```ruby
client.validate_token(token).valid?
```

### Documentation

The project owner will publish a README.md with each project.

The community can created linked and versioned documentation in the Wiki associated with this project:

https://github.com/code42/code42_api_ruby/wiki

### Bug / Issue tracking

[Please open a new issue](https://github.com/code42/code42_api_ruby/issues). Before opening any issue, please search for existing issues.

## Authors/Maintainers

[@ncolgan](http://github.com/ncolgan)

[@melissavoegeli](http://github.com/melissavoegeli)

## Contributors

[@jrmehle](http://github.com/jrmehle)

# Code 42 README

## What is this?

The Code 42 open source project is a set of frameworks and examples for developing solutions based on the Code 42 CrashPlan REST API.

* [CrashPlan product website](http://www.crashplan.com/enterprise)
* [CrashPlan online API documentation](http://www.crashplan.com/apidocviewer)
* [Code 42 Open Source on Github](https://github.com/code42)

Our goal is to give developers the tools necessary to build solutions that range from integration efforts to stand-alone application experiences.

##  Communication

The Code 42 API is available as an open source project on Github, located here:

* <https://github.com/code42>

Announcements, updates, bug fixes and issue tracking are managed within each repository listed.
