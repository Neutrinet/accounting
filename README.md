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

- unique login/password to access everything
- list transactions by year
- public accounting page by year
- upload CSV
  - upload form
  - create a "upload" db entry and fire up a bg job
  - display "import en cours" on the list transaction page
  - allow to filter by "unknown"
  - allow to edit transactions
  - make a difference between transactions created manually or by the import (a field in the DB)
  - generate reports for past years
- configure travis

