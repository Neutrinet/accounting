# README

- Setup locally (2 options):
  - [Setup locally by installing Ruby and Postgres](#setup-locally-by-installing-ruby-and-postgres)
  - [Setup locally with Docker](#setup-locally-with-docker)
- Detect new types of transactions
- Run the tests

## Setup locally by Installing Ruby and Postgres

### Install Ruby

- install `rbenv`: [follow those instructions](https://github.com/rbenv/rbenv#basic-github-checkout)
- install `ruby-build`: [follow those instructions](https://github.com/rbenv/ruby-build#installation) (install "As an rbenv plugin")
- install Ruby 2.5.1: `$ rbenv install 2.5.1`

### Install Postgres

- `$ sudo apt-get install postgres`

### Setup

- clone the app: `git clone xxx && cd yyy` 
- run the setup script: `bin/setup`

### Run the app locally

- `$ bundle exec rails s`
- visit http://localhost:3000

## Setup locally with Docker

- ...

## TODO

v unique login/password to access everything
v list transactions by year
v public accounting page by year
v add new movement
v do something with the nav header on the public page
v do a print CSS for pdf reporting
v add a "label" field for movements, and a new "custom" movement_type. the "label" will be displayed when the "custom" type is chosen
- upload CSV
  - upload form
  - create a "upload" db entry and fire up a bg job
  - display "import en cours" on the list transaction page
  - allow to filter by "unknown"
  - allow to edit transactions
  - make a difference between transactions created manually or by the import (a field in the DB)
  - generate reports for past years
- configure travis
- add specs for movement scopes
- fix failing spec on csv parsing
- documentation:
  - how to add new type
  - setup dev env
  - deploy to production
  - run tests
