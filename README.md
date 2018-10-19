# README

- [Setup locally](#setup-locally) (2 options):
  - [Setup locally by installing Ruby and Postgres](#setup-locally-by-installing-ruby-and-postgres)
  - [Setup locally with Docker](#setup-locally-with-docker)
- [Detect new types of transactions](#detect-new-types-of-transactions)

## Setup Locally

### Setup locally by Installing Ruby and Postgres

#### Needed packages

- `$ apt-get install git autoconf bison build-essential libssl-dev libyaml-dev libreadline-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev nodejs`
- `$ sudo apt-get install -t stretch-backports nodejs` (a recent version of node is needed)

#### Install Ruby

- install `rbenv`: [follow those instructions](https://github.com/rbenv/rbenv#basic-github-checkout)
- install `ruby-build`: [follow those instructions](https://github.com/rbenv/ruby-build#installation) (install "As an rbenv plugin")
- install Ruby 2.5.3: `$ rbenv install 2.5.3`
- set Ruby 2.5.3 as the default version: `$ rbenv global 2.5.3`
- test it worked: `$ ruby -v`

#### Install Postgres

- `$ sudo apt-get install postgresql libpq-dev`
- change default user's password:

```
$ sudo -u postgres psql postgres
# alter user postgres with password 'postgres';
# \q
```

#### Setup

- clone the app: `git clone xxx && cd yyy` 
- run the setup script: `bin/setup`

#### Run the tests
 
- in the project folder: `bin/cibuild`

#### Run the app locally

- `$ bundle exec rails s`
- visit http://localhost:3000
- the admin is available at: http://localhost:3000/admin
- the login is `admin` and the password can be found in the `.env` file found at the root of the application directory

### Setup locally with Docker

- TODO

## Detect new types of transactions

If a new recurring type of transaction shows up and you want the app to automatically detect it, follow those steps:
- in [specs/fixtures/movements](specs/fixtures/movements), add a new file prefixed with `ing`, e.g: `ing_my_new_transaction.csv`
- the first line in this file should contain the header of the CSV file, you can take one from [specs/fixtures/movements/ing_gandi.csv](specs/fixtures/movements/ing_gandi.csv)
- the second line should be an example of the transaction you want to automatically detect (don't forget to anonymize the line, e.g: name, bank account, ...)
- in [specs/models/movement_row_spec.rb](specs/models/movement_row_spec.rb), find the `example spec`, duplicate it and replace the values with what you expect to find from the CSV line
- run the specs (see above), they should fail
- add a method in [app/models/movement_identifier.rb](app/models/movement_identifier.rb) to detect your new transaction type. Run the tests, they should all pass.

## TODO

- configure travis
- add specs for movement scopes
- documentation:
  - deploy to production
