# Police Incidents API
This is an API that aims to hold the data for police incidents in the US in a centralized place. The current API data is sourced from [Washington Post's data of police shootings from 2015](https://github.com/washingtonpost/data-police-shootings/blob/master/fatal-police-shootings-data.csv) and onwards. We hope to add more data sources in the future.

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
Returns a JSON Array of all incidents:
```
GET /api/v1/incidents
```
Returns a particular incident according to id:
```
GET /api/v1/incidents/:id
```
### Optional filters and query params
Query params can be passed in to filter the data as follows:

* `last_name` The last name of the victim in the incident
* `age` The age of the victim in the incident
* `gender` The following letters are used to represent gender:
   * `M` Male
   * `F` Female
   * `None` Unknown
* `race` The following letters are used to represent race:
   * `W` White, non-Hispanic
   * `B` Black, non-Hispanic
   * `A` Asian
   * `N` Native American
   * `H` Hispanic
   * `O` Other
   * `None` Unknown
* `year` The year of the incident
* `city` The city the incident occurred in
* `state` The abbreviated state the incident occurred in
* `cause_of_death` The causes of death are as follows:
   * `shot`
   * `tasered`
   
Example query with filters:
```
GET /api/v1/incidents?last_name=Johnson&city=Chicago&state=IL&race=B&year=2015
```

## Code of Conduct

## Contributing

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

### TODO:
- [ ] Document, document, document
- [ ] Add more data sources, current seeds are only for 2020 and from Washington Post Data Source
- [ ] Add Code of Conduct
- [ ] Add Contributing Guide
