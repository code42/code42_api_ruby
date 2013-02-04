# Crashplan

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'crashplan'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install crashplan

## Configuration

```
client = Crashplan::Client.new(
  host: 'staging.crashplan.com',
  port: 1234,
  https: true,
  api_root: '/api/',
  username: 'testuser',
  password: 'letmein'
)
```

## Authentication

```
auth = client.auth
```

Then you can pass this token for further requests:

```
client = Crashplan::Client.new(
  host: 'staging.crashplan.com',
  port: 1234,
  https: true,
  api_root: '/api/',
  token: auth.token_string
)


## Usage

### Ping a host

```
success = client.ping().success?
```

### Fetch the currently authorized API user

```
user = client.user()
```

### Get the get a user by ID

```
user = client.user(42)
```

### Fetch the Org for the currently authorized API user

```
org = client.org()
```

### Fetch a specific Org by ID

```
org = client.org(42)
```
