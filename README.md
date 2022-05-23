# torba-rails

[![Build Status](https://img.shields.io/travis/torba-rb/torba-rails.svg)](https://travis-ci.org/torba-rb/torba-rails)
[![Gem version](https://img.shields.io/gem/v/torba-rails.svg)](https://rubygems.org/gems/torba-rails)

This gem provides integration for Ruby on Rails projects with the [Torba][torba-github] gem.

## Status

Production ready.

## Documentation

[Released version](http://rubydoc.info/gems/torba-rails/1.0.3)

## Installation

Add this line to your application's Gemfile and run `bundle`:

```ruby
gem 'torba-rails'
```

## Usage

The gem doesn't need extra configuration except the usual [Torba setup][torba-usage].

Non JS/CSS assets are automatically added to precompile list, no need to manually populate
`config.assets.precompile`.

Be careful to **import only assets that you really need**. Everything that is non JS or CSS asset is
going to be precompiled by Sprockets and accessible publicly. See [Rails ticket][rails-ticket-vendoring]
that explains this problem (and why Rails >= 4 precompiles only application.js/css in vendor by
default), except that Torba does have a way to specify exact list of files to import.

## Example

See fully configured [Rails application][rails-example].

## Deployment

torba-rails automatically hooks into the existing `assets:precompile`
Rake task to ensure that `torba pack` is executed. This means that Rails
deployments will "just work", although there are some optimizations you can make
as explained below.

### Heroku

You will need to specify some config vars to ensure Torba's files are placed in
locations suitable for the Heroku platform.

`TORBA_HOME_PATH` should be within your app so that Torba's assets are included
in the slug.

`TORBA_CACHE_PATH` should make use of the `tmp/cache/assets` directory. This is
where the Ruby buildpack expects cached files to be stored related to the
`assets:precompile` step. This way Torba doesn't have to download packages fresh
every time.

```bash
heroku config:set TORBA_HOME_PATH=vendor/torba TORBA_CACHE_PATH=tmp/cache/assets/torba
```

Now your Heroku app is good to go.

### Capistrano

Specify the `TORBA_HOME_PATH` env variable pointing to a persistent directory
writable by your deploy user and shared across releases. Capistrano's `shared`
directory is good for this.

For Capistrano 3, you can set this up in `config/deploy.rb`:

```
set :default_env, { torba_home_path: shared_path.join('vendor/torba') }
```

## Disable torba-rails

The gem tries its best to be activated when it is needed. Currently this
is aligned with serving assets by Rails, i.e. torba-rails is enabled
for development and testing and disabled for production (where assets are
served by an external web-server like nginx).

This default is fine for a single running local machine or server, but may
conflict with a multiple server setup. For example, you may want to precompile
assets on one machine and copy the compiled assets to many testing
machines/containers. On the testing machine you still want to serve the assets
by Rails, but you don't want torba-rails to kick in and start verifying its
assets. You don't want to run `torba pack` on each machine either.

In such situations you can prevent torba-rails from loading entirely.
Set an environment variable on a machine you don't want torba-rails to run:

```
export TORBA_RAILS_DISABLE=true
```

then conditionally `require` the gem:


```ruby
# Gemfile
gem 'torba-rails', require: ENV['TORBA_RAILS_DISABLE'] != 'true'
```

The gem will be still required on a machine without the variable set.

[torba-github]: https://github.com/torba-rb/torba
[torba-usage]: https://github.com/torba-rb/torba#usage
[rails-ticket-vendoring]: https://github.com/rails/rails/pull/7968
[rails-example]: https://github.com/torba-rb/rails-example
