# Crashplan

A Ruby interface to the Crashplan API

## Installation

Add this line to your application's Gemfile:

    gem 'crashplan'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install crashplan

## Configuration

    client = Crashplan::Client.new(
      host: 'staging.crashplan.com',
      port: 1234,
      https: true,
      api_root: '/api/',
      username: 'testuser',
      password: 'letmein'
    )

## Authentication

```
token = client.get_token
```

Then you can pass this token for further requests:

    client = Crashplan::Client.new(
      host: 'staging.crashplan.com',
      port: 1234,
      https: true,
      api_root: '/api/',
      token: token
    )

## User

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

## Org

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
