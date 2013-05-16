# Code 42 API Ruby Gem

A Ruby interface to the Code 42 API

## Installation

Add this line to your application's Gemfile:

    gem 'code42'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install code42

## Configuration

    client = Code42::Client.new(
      host: 'staging.code42.com',
      port: 1234,
      https: true,
      api_root: '/api/',
      username: 'testuser',
      password: 'letmein'
    )

### Authentication

```
token = client.get_token
```

Then you can pass this token for further requests:

    client = Code42::Client.new(
      host: 'staging.code42.com',
      port: 1234,
      https: true,
      api_root: '/api/',
      token: token
    )

## Resources

### User

attributes:

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

### Org

attributes:

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

## Usage

### Ping a host

```
success = client.ping.success?
```

### Fetch the currently authorized API user

```
user = client.user
```

### Get the get a user by ID

```
user = client.user(42)
```

### Fetch the Org for the currently authorized API user

```
org = client.org
```

### Fetch a specific Org by ID

```
org = client.org(42)
```

### Validate a token

```
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

# Code 42 README

## What is this?

The Code 42 open source project is a set of frameworks and examples for developing solutions based on the Code 42 CrashPlan REST API.

* [CrashPlan product website](http://www.code42.com/enterprise)
* [CrashPlan online API documentation](http://www.crashplan.com/apidocviewer)
* [Code 42 Open Source on Github](https://github.com/code42)

Our goal is to give developers the tools necessary to build solutions that range from integration efforts to stand-alone application experiences.

##  Communication

The Code 42 API is available as an open source project on Github, located here:

* <https://github.com/code42>

Announcements, updates, bug fixes and issue tracking are managed within each repository listed.

## Copyright and Licensing

Unless otherwise noted, all files and works contained in the Code 42 projects are covered by the Apache 2 license as detailed below:

>Copyright 2013, Code 42 Software Inc.

>Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

> <http://www.apache.org/licenses/LICENSE-2.0 >

> Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
