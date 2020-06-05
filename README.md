# Police Incidents API

## Table of contents

* [Installation](#installation)
* [Endpoints](#endpoints)
* [Code of Conduct](#code-of-conduct)
* [Contributing](#contributing)
* [License](#license)

## Installation

### Mac OSX Prerequisites

1. Make sure xcode is up to date.
   ```
   xcode-select --install
   ```
2. Install Homebrew
   ```
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
   ```
3. This project uses Ruby 2.7.1, which is best installed through rbenv.

   ```
   brew install rbenv
   ```

   ```
   brew install ruby-build
   ```

   ```
   rbenv install 2.3.3
   rbenv global 2.3.3
   ```

   ⚠️ If you see an error when trying to install Ruby, something along the lines of:

   > ERROR: Ruby install aborted due to missing extensions
   > Try the following line to install Ruby 2.7.1

   ```
   RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl" rbenv install 2.7.1
   ```

   At this point, you want to restart your terminal to ensure everything takes effect.

4. Install RSpec for testing

   ```
   gem install rspec
   ```

   Restart terminal again.

   ⚠️ Important note: You should NEVER need to sudo gem install \_\_\_ anything. If you get a permission issue, that means your system isn't using the rbenv/rvm version of rubygems.

5. Install Postgres Database
   ```
   brew install postgres
   ```
6. Create a physical postgresql database
   ```
   initdb /usr/local/var/postgres
   ```
   You can start and stop the database with the following commands. These are nice to create as an [alias within your .bash_profile](https://mijingo.com/blog/creating-bash-aliases)
   ```
   pg_ctl -D /usr/local/var/postgres start
   pg_ctl -D /usr/local/var/postgres stop
   ```
7. Install ruby's gem bundler
   ```
   gem install bundler
   ```

### Getting the app started

1. Clone this repo

2. Run `bundle install`

3. Run `rake db:setup`

4. Run `rake db:seed`

5. Run the application using `rails s`

6. Open your browser to `localhost:3000/incidents` and see the result


## Endpoints
```
/incidents
```
```
/incidents/:id
```
```
/incidents?city=Chicago&race=A
```
## Code of Conduct

## Contributing

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

### TODO:
- [ ] Document, document, document
- [ ] Create a filter for a date range or a year as a query param
- [ ] Upload previous years, current seeds are only for 2020 and from Washington Post Data Source
- [ ] Add Code of Conduct
- [ ] Add Contributing Guide
